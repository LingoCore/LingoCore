#!/bin/bash

# 1. POST login and get accessToken
ACCESS_TOKEN=$(curl -s -X POST "http://localhost:3000/api/auth/testlogin" \
  -H "Content-Type: application/json" \
  -d '{"username":"deniztunc"}' | jq -r '.accessToken')

echo "Access Token: $ACCESS_TOKEN"
echo ""

# 2.5 Set auth header for subsequent requests
AUTH_HEADER="Authorization: Bearer $ACCESS_TOKEN"

# 3. GET course list
COURSES_JSON=$(curl -s -X GET "http://localhost:3000/api/course/list/all" \
  -H "$AUTH_HEADER")

# 4. Extract first course ID
FIRST_COURSE_ID=$(echo "$COURSES_JSON" | jq -r '.courses[0].id')

echo "Enrolling in course with ID: $FIRST_COURSE_ID"
echo ""

# 5. POST course enrollment
ENROLL_RESPONSE=$(curl -s -X POST "http://localhost:3000/api/course/enroll" \
  -H "Content-Type: application/json" \
  -H "$AUTH_HEADER" \
  -d "{\"courseId\":\"$FIRST_COURSE_ID\"}")

echo "Enrollment response:"
echo "$ENROLL_RESPONSE" | jq