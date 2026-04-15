# Create a CLTV script with a timestamp of 1495584032 and public key below:
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
locktime=1495584032
locktime_hex_le=$(printf '%08x' "$locktime" | sed -E 's/(..)(..)(..)(..)/\4\3\2\1/')

# Build HASH160(pubkey) for the P2PKH tail.
pubkey_hash=$(echo -n "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 | awk '{print $2}')

script="04${locktime_hex_le}b17576a914${pubkey_hash}88ac"

echo "$script"
