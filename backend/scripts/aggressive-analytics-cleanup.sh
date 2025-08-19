#!/bin/bash
# Script to aggressively clean up ALL analytics data

# Load environment variables
source .env 2>/dev/null || true

# Get the environment (default to production)
ENV=${1:-production}
MODE=${2:-all}  # all, views, trending
DRY_RUN=${3:-true}  # true or false

# Set the API URL based on environment
if [ "$ENV" = "development" ]; then
    API_URL="http://localhost:8787"
else
    API_URL="https://api.openvine.co"
fi

# Set the auth token
AUTH_TOKEN=${CLEANUP_AUTH_TOKEN:-"your-secure-cleanup-token"}

echo "🧹 Aggressive Analytics Cleanup"
echo "==============================="
echo "Environment: $ENV"
echo "Mode: $MODE"
echo "Dry Run: $DRY_RUN"
echo "URL: $API_URL/analytics/cleanup/aggressive"
echo ""

if [ "$DRY_RUN" = "false" ]; then
    read -p "⚠️  WARNING: This will DELETE ALL analytics data! Continue? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Operation cancelled"
        exit 1
    fi
fi

# Make the cleanup request
echo "🔄 Sending cleanup request..."
response=$(curl -X GET "$API_URL/analytics/cleanup/aggressive?mode=$MODE&dry_run=$DRY_RUN" \
    -H "Authorization: Bearer $AUTH_TOKEN" \
    -H "Content-Type: application/json" \
    -s -w "\nHTTP_STATUS:%{http_code}")

# Extract HTTP status
http_status=$(echo "$response" | grep -o "HTTP_STATUS:[0-9]*" | cut -d: -f2)
body=$(echo "$response" | sed '/HTTP_STATUS:/d')

# Pretty print JSON response
if command -v jq &> /dev/null; then
    formatted_body=$(echo "$body" | jq '.' 2>/dev/null || echo "$body")
else
    formatted_body="$body"
fi

# Check response
if [ "$http_status" = "200" ]; then
    echo "✅ Cleanup request successful!"
    echo ""
    echo "Response:"
    echo "$formatted_body"
    
    if [ "$DRY_RUN" = "true" ]; then
        echo ""
        echo "💡 This was a DRY RUN. To actually delete data, run:"
        echo "  $0 $ENV $MODE false"
    fi
else
    echo "❌ Cleanup failed with status $http_status"
    echo "Response: $formatted_body"
    exit 1
fi