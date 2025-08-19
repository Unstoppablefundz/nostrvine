#!/bin/bash

# Analytics Cache Flush Script
# Flushes cached analytics data from ANALYTICS_KV namespace
# Note: Actual video views are stored in Analytics Engine dataset nostrvine_video_views

set -e

BINDING="ANALYTICS_KV"
DRY_RUN=${1:-true}

echo "🧹 OpenVine Analytics Cache Flush"
echo "================================="
echo "KV Binding: $BINDING (cache storage)" 
echo "Dry Run: $DRY_RUN"
echo ""
echo "⚠️  Note: This only clears the KV cache. Actual analytics data is in Analytics Engine."
echo ""

echo "📋 Listing all keys in analytics KV namespace..."
KEYS_JSON=$(wrangler kv key list --binding "$BINDING" 2>/dev/null || echo "[]")

if [ "$KEYS_JSON" = "[]" ]; then
    echo "✅ No keys found in analytics KV namespace - database is already empty"
    exit 0
fi

echo "🔍 Found analytics keys..."
# Analytics keys patterns: views:*, trending:*, user:*, hashtag:*, creator:*
ANALYTICS_KEYS=$(echo "$KEYS_JSON" | jq -r '.[].name' | grep -E '^(views:|trending:|user:|hashtag:|creator:|video:|analytics:)' || true)

if [ -z "$ANALYTICS_KEYS" ]; then
    echo "✅ No analytics keys found - nothing to flush"
    exit 0
fi

ANALYTICS_COUNT=$(echo "$ANALYTICS_KEYS" | wc -l)
echo "📊 Found $ANALYTICS_COUNT analytics keys to delete:"
echo "$ANALYTICS_KEYS" | head -20 | sed 's/^/  - /'
if [ $ANALYTICS_COUNT -gt 20 ]; then
    echo "  ... and $((ANALYTICS_COUNT - 20)) more"
fi

if [ "$DRY_RUN" = "true" ]; then
    echo ""
    echo "⚠️  DRY RUN - Keys shown above would be deleted"
    echo "🔄 To actually delete these keys, run:"
    echo "  $0 false"
    exit 0
fi

echo ""
read -p "⚠️  Are you sure you want to delete ALL analytics data? This cannot be undone! (y/N) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Operation cancelled"
    exit 1
fi

echo ""
echo "🗑️  Deleting analytics keys..."

# Delete keys in batches to avoid timeouts
BATCH_SIZE=10
COUNTER=0

echo "$ANALYTICS_KEYS" | while IFS= read -r key; do
    if [ -n "$key" ]; then
        echo "  Deleting: $key"
        wrangler kv key delete "$key" --binding "$BINDING" --force 2>/dev/null || true
        
        COUNTER=$((COUNTER + 1))
        if [ $((COUNTER % BATCH_SIZE)) -eq 0 ]; then
            echo "  ... processed $COUNTER keys"
            sleep 0.5  # Small delay to avoid rate limits
        fi
    fi
done

echo ""
echo "✅ Analytics database flush completed!"

echo ""
echo "🔍 Verifying flush..."
REMAINING_KEYS=$(wrangler kv key list --binding "$BINDING" 2>/dev/null || echo "[]")
REMAINING_ANALYTICS=$(echo "$REMAINING_KEYS" | jq -r '.[].name' | grep -E '^(views:|trending:|user:|hashtag:|creator:|video:|analytics:)' || true)

if [ -z "$REMAINING_ANALYTICS" ]; then
    echo "🎉 All analytics keys successfully removed!"
    echo ""
    echo "💡 Next steps:"
    echo "  1. New video views will start populating fresh analytics data"
    echo "  2. Trending calculation will update with only active videos"
    echo "  3. Monitor /analytics/trending/vines to see fresh data"
else
    REMAINING_COUNT=$(echo "$REMAINING_ANALYTICS" | wc -l)
    echo "⚠️  Warning: $REMAINING_COUNT analytics keys may remain:"
    echo "$REMAINING_ANALYTICS" | head -10 | sed 's/^/  - /'
    if [ $REMAINING_COUNT -gt 10 ]; then
        echo "  ... and $((REMAINING_COUNT - 10)) more"
    fi
fi