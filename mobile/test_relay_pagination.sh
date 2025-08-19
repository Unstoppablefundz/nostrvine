#!/bin/bash

echo "Testing relay3.openvine.co for kind 32222 events..."
echo ""

# First request - get recent videos
echo "📹 First batch - requesting 5 recent videos..."
RESPONSE1=$(echo '["REQ", "sub1", {"kinds": [32222], "limit": 5}]' | timeout 3 websocat -t wss://relay3.openvine.co 2>/dev/null | grep EVENT || echo "No events received")

if [ "$RESPONSE1" = "No events received" ]; then
    echo "❌ Failed to get events from relay"
    exit 1
fi

echo "Got response:"
echo "$RESPONSE1" | head -3

# Extract timestamps from the response
TIMESTAMPS=$(echo "$RESPONSE1" | sed -n 's/.*"created_at":\([0-9]*\).*/\1/p' | sort -n | head -1)

if [ -z "$TIMESTAMPS" ]; then
    # Try different parsing
    TIMESTAMPS=$(echo "$RESPONSE1" | grep -o '"created_at":[0-9]*' | sed 's/"created_at"://' | sort -n | head -1)
fi

if [ -z "$TIMESTAMPS" ]; then
    echo "Could not extract timestamps, trying raw extraction..."
    # Extract from raw EVENT format: ["EVENT", "sub", {"id":"...", "pubkey":"...", "created_at":timestamp, ...}]
    TIMESTAMPS=$(echo "$RESPONSE1" | grep -o '"created_at":[0-9]*' | sed 's/"created_at"://' | sort -n | head -1)
fi

echo ""
echo "Oldest timestamp from first batch: $TIMESTAMPS"

if [ ! -z "$TIMESTAMPS" ]; then
    echo ""
    echo "📹 Second batch - requesting videos older than $TIMESTAMPS..."
    RESPONSE2=$(echo "[\"REQ\", \"sub2\", {\"kinds\": [32222], \"until\": $TIMESTAMPS, \"limit\": 5}]" | timeout 3 websocat -t wss://relay3.openvine.co 2>/dev/null | grep EVENT || echo "No events received")
    
    echo "Got response:"
    echo "$RESPONSE2" | head -3
    
    # Check if we got different events
    if [ "$RESPONSE2" != "No events received" ]; then
        echo ""
        echo "✅ Successfully tested pagination with 'until' parameter!"
    else
        echo "❌ No events received with pagination"
    fi
else
    echo "❌ Could not extract timestamps for pagination test"
fi