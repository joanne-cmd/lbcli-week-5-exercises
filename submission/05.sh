# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
csv_blocks=150
publicKey="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"
csv_hex_le="$(printf '%02x' "$csv_blocks")00"

# Build HASH160(pubkey) for the P2PKH tail.
pubkey_hash=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 | awk '{print $2}')

script="02${csv_hex_le}b27576a914${pubkey_hash}88ac"
echo "$script"
