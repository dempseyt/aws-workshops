BUCKET_NAME="$1"
REGION="$(aws configure get region --profile sandbox-admin)"

WEBSITE_URL="http://${BUCKET_NAME}.s3-website-${REGION}.amazonaws.com"

echo ${WEBSITE_URL} | xclip -selection clipboard 
