#\!/bin/bash
# Check Analytics Engine datasets

# Get secrets from wrangler
ACCOUNT_ID=$(wrangler secret list --name CLOUDFLARE_ACCOUNT_ID 2>/dev/null | grep -oP '(?<=value: ")[^"]*' || echo "")
API_TOKEN=$(wrangler secret list --name CLOUDFLARE_API_TOKEN 2>/dev/null | grep -oP '(?<=value: ")[^"]*' || echo "")

if [ -z "$ACCOUNT_ID" ] || [ -z "$API_TOKEN" ]; then
    echo "Error: Could not retrieve Cloudflare credentials"
    echo "Please ensure CLOUDFLARE_ACCOUNT_ID and CLOUDFLARE_API_TOKEN are set as secrets"
    exit 1
fi

echo "Checking Analytics Engine datasets..."
echo ""

# List all datasets
curl -s -X GET "https://api.cloudflare.com/client/v4/accounts/$ACCOUNT_ID/analytics_engine/datasets" \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" | jq '.'

echo ""
echo "If no datasets are shown, you may need to create them in the Cloudflare dashboard"
