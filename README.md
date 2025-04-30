# TCCLI Certificate Updater

This tool automates the process of updating SSL certificates in Tencent Cloud using the Tencent Cloud CLI (TCCLI). It extracts certificates from Traefik's `acme.json` file and updates them in Tencent Cloud.

## Prerequisites

- Docker and Docker Compose installed on your system
- Tencent Cloud account with appropriate permissions
- Traefik with `acme.json` file containing your certificates

## Setup Instructions

### Step 1: Configure the TCCLI Profile

1. Copy the example profile file to create your configuration:

```bash
cp tccli-profile.example.sh tccli-profile.sh
```

2. Edit the `tccli-profile.sh` file with your Tencent Cloud credentials and certificate details:

```bash
# define the API key pairs for connecting to Tencent Cloud 
export TENCENTCLOUD_SECRET_ID=your_secret_id_here
export TENCENTCLOUD_SECRET_KEY=your_secret_key_here
export TENCENTCLOUD_REGION=your_region_here

# define the DOMAIN for updating cert, OldCertificateId is a Tencent Cert ID to be updated 
export DOMAIN=your.domain.com
export OldCertificateId=your_certificate_id_here
```

### Step 2: Update the Certificate

Run the following command to execute the certificate update process:

```bash
docker compose run --rm updatecert
```

## How It Works

1. The tool mounts your Traefik's `acme.json` file as read-only
2. It extracts the certificate and private key for the specified domain
3. Using TCCLI, it updates the existing certificate in Tencent Cloud
4. The certificate is configured to be repeatable and downloadable

## Configuration

- Modify `docker-compose.yaml` if your `acme.json` is located in a different path
- The container uses minimal resources by default (0.1 CPU, 32MB memory)

## Troubleshooting

If you encounter issues:
- Verify your Tencent Cloud credentials are correct
- Ensure the specified domain exists in your `acme.json` file
- Check that the `OldCertificateId` is valid in your Tencent Cloud account

## Security Notes

- The `tccli-profile.sh` file contains sensitive credentials and is excluded from git tracking
- Always ensure your credentials are properly secured

        
