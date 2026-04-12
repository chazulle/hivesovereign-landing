#!/bin/bash

# HIVE Sovereign — Vercel Quick Deploy
# Run this script to deploy in 60 seconds

set -e

echo "=================================="
echo "HIVE Sovereign Landing Page Deploy"
echo "=================================="
echo ""

# Check if in correct directory
if [ ! -f "index.html" ]; then
    echo "❌ Error: index.html not found"
    echo "Run this script from the hivesovereign-landing directory"
    exit 1
fi

echo "✅ Files verified"
echo ""

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Vercel CLI not found. Installing..."
    npm install -g vercel
    echo "✅ Vercel CLI installed"
else
    echo "✅ Vercel CLI already installed"
fi

echo ""
echo "🚀 Deploying to Vercel..."
echo ""

# Deploy to Vercel (this will prompt for login if needed)
vercel --prod

echo ""
echo "=================================="
echo "✅ DEPLOYMENT COMPLETE"
echo "=================================="
echo ""
echo "📋 NEXT STEPS:"
echo ""
echo "1. Copy the deployment URL from above"
echo "2. Test the site in your browser"
echo "3. Connect custom domain:"
echo "   - Go to Vercel dashboard"
echo "   - Settings → Domains"
echo "   - Add: hivesovereign.com"
echo "   - Follow DNS instructions"
echo ""
echo "4. Update form webhook:"
echo "   - Set up NoCodeBackend first"
echo "   - Edit index.html form handler (line 1102)"
echo "   - Replace placeholder with NoCodeBackend endpoint"
echo "   - Redeploy: vercel --prod"
echo ""
echo "=================================="
