#!/bin/bash

AWS_PROFILE='sandbox-admin'
read -rd "" CACHE_POLICY_CONFIG << JSON 
{
    "Name": "CloudFrontCachePolicy",
    "Comment": "Cache Policy For CloudFront",
    "MinTTL": 3600
}
JSON

 aws cloudfront create-cache-policy --cache-policy-config "${CACHE_POLICY_CONFIG}" --profile ${AWS_PROFILE} --output text | jq 