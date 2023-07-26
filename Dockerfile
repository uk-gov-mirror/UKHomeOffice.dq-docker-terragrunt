ARG TERRAFORM_VERSION=${TERRAFORM_VERSION}
FROM hashicorp/terraform:${TERRAFORM_VERSION}

RUN apk add --update --upgrade --no-cache bash git openssh \
    libtasn1 \
    musl \
    curl \
    libgcrypt
RUN rm -rf /var/cache/apk /root/.cache

ARG TERRAGRUNT_VERSION=${TERRAGRUNT_VERSION}

ADD https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 /usr/local/bin/terragrunt

RUN chmod +x /usr/local/bin/terragrunt

WORKDIR /apps

ENTRYPOINT ["/usr/local/bin/terragrunt"]
