#!/bin/bash

# Default key name
KEY_NAME="rsa"

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --name)
      KEY_NAME="$2"
      shift # past argument
      shift # past value
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Generate private key
openssl genrsa \
-out ${KEY_NAME}-private-key.pem \
2048
if [[ $? -eq 0 ]]; then
  echo "GENERATED PRIVATE KEY: ${KEY_NAME}-private-key.pem"
else
  echo "Failed to generate private key"
  exit 1
fi

# Generate public key
openssl rsa -in ${KEY_NAME}-private-key.pem \
-pubout \
-outform PEM \
-out ${KEY_NAME}-public-key.pem
if [[ $? -eq 0 ]]; then
  echo "GENERATED PUBLIC KEY: ${KEY_NAME}-public-key.pem"
else
  echo "Failed to generate public key"
  exit 1
fi
