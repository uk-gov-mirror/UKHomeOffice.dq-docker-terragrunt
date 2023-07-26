# Terraform version passed in from Drone
ARG TERRAFORM_VERSION=${TERRAFORM_VERSION}
# Base our Docker image on the prescribed version of Terraform
FROM hashicorp/terraform:${TERRAFORM_VERSION}

# Add the latest required packages
RUN apk add --update --upgrade --no-cache bash \
    git \
    openssh \
    libtasn1 \
    musl \
    curl \
    libgcrypt
RUN rm -rf /var/cache/apk /root/.cache

# Terragrunt version passed in from Drone
ARG TERRAGRUNT_VERSION=${TERRAGRUNT_VERSION}

# Download the specific version of Terragrunt, which isdesigned to work with the prescribed version of Terraform, and add to image
ADD https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 /usr/local/bin/terragrunt

# Make Terragrunt executable
RUN chmod +x /usr/local/bin/terragrunt

WORKDIR /apps

# When this Docker Image is called, run Terragrunt executable
ENTRYPOINT ["/usr/local/bin/terragrunt"]
