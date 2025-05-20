decodeJwt() {
	local jwt
	local header
	local payload
	local signature

	# Check if input is from pipe or parameter
	if [ -p /dev/stdin ]; then
		# Read from stdin if piped
		jwt=$(cat)
	else
		# Otherwise, use the first parameter
		jwt="$1"
	fi

	# Exit if no JWT provided
	if [ -z "$jwt" ]; then
		echo "Error: No JWT token provided"
		echo "Usage: decodeJwt <token> or echo <token> | decodeJwt"
		return 1
	fi

	# Validate JWT format (should have exactly 2 periods)
	if [[ ! "$jwt" =~ ^[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+$ ]]; then
		echo "Error: Invalid JWT format. Expected format: header.payload.signature"
		return 1
	fi

	# Split JWT into header, payload, and signature; then decode with basenc and format
  IFS='.' read -r header payload signature <<< "$jwt"
	header=$(echo "$header" | basenc -d --base64url 2>/dev/null | jq)
	payload=$(echo "$payload" | basenc -d --base64url 2>/dev/null | jq)

	# Print the decoded header and payload
	echo "\nHeader: $header"
	echo "\nPayload: $payload"
}
