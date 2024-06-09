#!/bin/bash
BUCKET_NAME="aws-workshop-$(uuidgen)"
BUCKET_URI="s3://$BUCKET_NAME"
echo $BUCKET_NAME > bucket_name.txt
aws s3 mb "$BUCKET_URI" --profile sandbox-admin
aws s3 website "$BUCKET_URI" --profile sandbox-admin --index-document index.html
