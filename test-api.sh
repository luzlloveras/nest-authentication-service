#!/bin/bash

echo "=== Testing Authentication Service ==="
echo ""

# Check if server is running
if ! curl -s http://localhost:3000 > /dev/null; then
  echo "❌ Server is not running on http://localhost:3000"
  echo "   Please start the server with: npm run start:dev"
  exit 1
fi

echo "✅ Server is running"
echo ""

# Generate random username to avoid conflicts
RANDOM_USER="testuser$(date +%s)"

# Test 1: Register
echo "1. Testing POST /auth/register..."
echo "   Request: POST http://localhost:3000/auth/register"
echo "   Body: {\"username\":\"$RANDOM_USER\",\"password\":\"SecurePass123!\"}"
echo ""

REGISTER_RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"$RANDOM_USER\",\"password\":\"SecurePass123!\"}")

REGISTER_HTTP_CODE=$(echo "$REGISTER_RESPONSE" | grep "HTTP_CODE" | cut -d: -f2)
REGISTER_BODY=$(echo "$REGISTER_RESPONSE" | sed '/HTTP_CODE/d')

echo "   HTTP Status: $REGISTER_HTTP_CODE"
echo "   Response:"
if [ -z "$REGISTER_BODY" ]; then
  echo "   (empty response)"
else
  echo "$REGISTER_BODY" | python3 -m json.tool 2>/dev/null || echo "$REGISTER_BODY"
fi
echo ""

if [ "$REGISTER_HTTP_CODE" != "200" ] && [ "$REGISTER_HTTP_CODE" != "201" ]; then
  echo "❌ Registration failed with HTTP $REGISTER_HTTP_CODE"
  echo "   Check server logs for errors"
  exit 1
fi

echo "✅ User registered successfully!"
echo ""

# Test 2: Login
echo "2. Testing POST /auth/login..."
echo "   Request: POST http://localhost:3000/auth/login"
echo "   Body: {\"username\":\"$RANDOM_USER\",\"password\":\"SecurePass123!\"}"
echo ""

LOGIN_RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"$RANDOM_USER\",\"password\":\"SecurePass123!\"}")

HTTP_CODE=$(echo "$LOGIN_RESPONSE" | grep "HTTP_CODE" | cut -d: -f2)
RESPONSE_BODY=$(echo "$LOGIN_RESPONSE" | sed '/HTTP_CODE/d')

echo "   HTTP Status: $HTTP_CODE"
echo "   Response:"
if [ -z "$RESPONSE_BODY" ]; then
  echo "   (empty response)"
else
  echo "$RESPONSE_BODY" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE_BODY"
fi
echo ""

if [ "$HTTP_CODE" != "200" ] && [ "$HTTP_CODE" != "201" ]; then
  echo "❌ Login failed with HTTP $HTTP_CODE"
  echo "   Check server logs for errors"
  exit 1
fi

# Extract tokens
ACCESS_TOKEN=$(echo "$RESPONSE_BODY" | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)
REFRESH_TOKEN=$(echo "$RESPONSE_BODY" | grep -o '"refresh_token":"[^"]*' | cut -d'"' -f4)

if [ -z "$ACCESS_TOKEN" ]; then
  echo "❌ Failed to get access token from response."
  echo "   Response was: $RESPONSE_BODY"
  exit 1
fi

if [ -z "$REFRESH_TOKEN" ]; then
  echo "❌ Failed to get refresh token from response."
  echo "   Response was: $RESPONSE_BODY"
  exit 1
fi

echo "✅ Tokens obtained:"
echo "   Access Token: ${ACCESS_TOKEN:0:50}..."
echo "   Refresh Token: ${REFRESH_TOKEN:0:50}..."
echo ""

# Test 3: Get Profile
echo "3. Testing GET /auth/profile with access token..."
PROFILE_RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" -X GET http://localhost:3000/auth/profile \
  -H "Authorization: Bearer $ACCESS_TOKEN")

PROFILE_HTTP_CODE=$(echo "$PROFILE_RESPONSE" | grep "HTTP_CODE" | cut -d: -f2)
PROFILE_BODY=$(echo "$PROFILE_RESPONSE" | sed '/HTTP_CODE/d')

echo "   HTTP Status: $PROFILE_HTTP_CODE"
echo "   Response:"
if [ -z "$PROFILE_BODY" ]; then
  echo "   (empty response)"
else
  echo "$PROFILE_BODY" | python3 -m json.tool 2>/dev/null || echo "$PROFILE_BODY"
fi
echo ""

if echo "$PROFILE_BODY" | grep -q "username"; then
  echo "✅ Profile endpoint working correctly!"
else
  echo "❌ Profile endpoint failed. HTTP Status: $PROFILE_HTTP_CODE"
fi
echo ""

# Test 4: Refresh Token
echo "4. Testing POST /auth/refresh with refresh token..."
REFRESH_RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" -X POST http://localhost:3000/auth/refresh \
  -H "Content-Type: application/json" \
  -d "{\"refresh_token\":\"$REFRESH_TOKEN\"}")

REFRESH_HTTP_CODE=$(echo "$REFRESH_RESPONSE" | grep "HTTP_CODE" | cut -d: -f2)
REFRESH_BODY=$(echo "$REFRESH_RESPONSE" | sed '/HTTP_CODE/d')

echo "   HTTP Status: $REFRESH_HTTP_CODE"
echo "   Response:"
if [ -z "$REFRESH_BODY" ]; then
  echo "   (empty response)"
else
  echo "$REFRESH_BODY" | python3 -m json.tool 2>/dev/null || echo "$REFRESH_BODY"
fi
echo ""

NEW_ACCESS_TOKEN=$(echo "$REFRESH_BODY" | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)

if [ -n "$NEW_ACCESS_TOKEN" ]; then
  echo "✅ Refresh token working! New access token: ${NEW_ACCESS_TOKEN:0:50}..."
  ACCESS_TOKEN="$NEW_ACCESS_TOKEN"
else
  echo "❌ Refresh token failed. HTTP Status: $REFRESH_HTTP_CODE"
fi
echo ""

# Test 5: Logout
echo "5. Testing POST /auth/logout..."
LOGOUT_RESPONSE=$(curl -s -w "\nHTTP_CODE:%{http_code}" -X POST http://localhost:3000/auth/logout \
  -H "Authorization: Bearer $ACCESS_TOKEN")

LOGOUT_HTTP_CODE=$(echo "$LOGOUT_RESPONSE" | grep "HTTP_CODE" | cut -d: -f2)
LOGOUT_BODY=$(echo "$LOGOUT_RESPONSE" | sed '/HTTP_CODE/d')

echo "   HTTP Status: $LOGOUT_HTTP_CODE"
echo "   Response:"
if [ -z "$LOGOUT_BODY" ]; then
  echo "   (empty response)"
else
  echo "$LOGOUT_BODY" | python3 -m json.tool 2>/dev/null || echo "$LOGOUT_BODY"
fi
echo ""

if [ "$LOGOUT_HTTP_CODE" = "200" ]; then
  echo "✅ Logout successful!"
else
  echo "❌ Logout failed. HTTP Status: $LOGOUT_HTTP_CODE"
fi

echo ""
echo "=== All tests completed ==="
