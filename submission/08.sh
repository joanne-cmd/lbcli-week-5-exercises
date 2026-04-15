# Create a time-based CSV script that would lock funds for 6 months (using 30-day months)
# Time-based CSV uses 512-second units with the type flag (bit 22) set
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
publicKey="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"

# Step 1: 6 months (30 days each) -> seconds, then convert to 512-second units.
seconds=$((6 * 30 * 24 * 60 * 60))
units=$((seconds / 512))

# Step 2: Set bit 22 to mark it as time-based CSV.
csv_value=$(((1 << 22) | units))

# Step 3: Encode as 3-byte little-endian script number.
csv_hex_le=$(printf '%06x' "$csv_value" | sed -E 's/(..)(..)(..)/\3\2\1/')

# Build HASH160(pubkey) for the P2PKH tail.
pubkey_hash=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 | awk '{print $2}')

script="03${csv_hex_le}b27576a914${pubkey_hash}88ac"
echo "$script"
