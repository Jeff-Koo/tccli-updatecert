#!/bin/bash
echo "### START UPDATE CERT ###";

. /etc/tccli-profile.sh;
echo "Extract Cert for DOMAIN: $DOMAIN";

# Extract the certificate
CERTIFICATE=$(jq -r '.letsencrypt.Certificates[] | select(.domain.main=="'"$DOMAIN"'") | .certificate' /data/acme.json | base64 -d | awk '{printf "%s\n", $0}' | sed 's/\n\n/\n/g; s/\n$//')
echo "Extracted Certificate: $CERTIFICATE"

# Extract the private key
PRIVATE_KEY=$(jq -r '.letsencrypt.Certificates[] | select(.domain.main=="'"$DOMAIN"'") | .key' /data/acme.json | base64 -d | awk '{printf "%s\n", $0}' | sed 's/\n\n/\n/g; s/\n$//')
echo "Extracted Private Key: $PRIVATE_KEY"

echo "Start Updating Cert via tccli..."

# Update the certificate and key
tccli ssl UpdateCertificateInstance \
  --cli-unfold-argument --OldCertificateId "$OldCertificateId" --ResourceTypes clb \
  --CertificatePublicKey "$CERTIFICATE" --CertificatePrivateKey "$PRIVATE_KEY" \
  --Repeatable True --AllowDownload True \

echo "### EXIT ###"
