#!/bin/bash

AWS_PROFILE=sandbox-admin
BUCKET_NAME=$1
DISTRIBUTION_CONFIG=$(cat <<JSON
{
	"CallerReference": "48eacd1b-9f61-4dd4-9497-2b82c0ec5332",
	"DefaultCacheBehavior": {
		"TargetOriginId": "MyBucket",
		"ViewerProtocolPolicy": "redirect-to-https", 
		"AllowedMethods": {
			"Quantity": 2,
			"Items": [
				"GET",
				"HEAD"
			]
		},
		"CachePolicyId":"623a0565-8d70-4eeb-ba2f-1daacb61b803"
	},
	"Origins": {
		"Quantity": 1,
		"Items": [
			{
				"S3OriginConfig": {
					"OriginAccessIdentity": ""	
				},
				"Id": "MyBucket",
				"DomainName": "${BUCKET_NAME}.s3.$(aws configure get region).amazonaws.com",
				"CustomHeaders": {
					"Quantity": 0
				}
			}
		]
	},
	"Comment": "A CloudFront distribution for MyBucket :)",
	"Enabled": true,
	"CacheBehaviors": {
		"Quantity": 1,
		"Items": [
			{
				"PathPattern": "/*",
				"TargetOriginId": "MyBucket",
				"ViewerProtocolPolicy": "redirect-to-https",
				"CachePolicyId":"623a0565-8d70-4eeb-ba2f-1daacb61b803"
			}
		]
	}
}
JSON
)

aws cloudfront create-distribution --distribution-config="${DISTRIBUTION_CONFIG}" --profile sandbox-admin

