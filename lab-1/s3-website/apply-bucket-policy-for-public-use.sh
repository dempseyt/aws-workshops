#!/bin/bash

BUCKET_NAME=$1
BUCKET_POLICY_FILE=$(mktemp /tmp/bucket-policy.XXXXXX.json)
cat <<EOF > ${BUCKET_POLICY_FILE}
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "PublicReadGetObject",
			"Effect": "Allow",
			"Principal": "*",
			"Action": [
				"s3:GetObject"
			],
			"Resource": [
				"arn:aws:s3:::${BUCKET_NAME}/*"
			]	
		}
	]
}
EOF

aws s3api put-bucket-policy --profile sandbox-admin --bucket "${BUCKET_NAME}" --policy file://"${BUCKET_POLICY_FILE}"
rm -rf ${BUCKET_POLICY_NAME}
