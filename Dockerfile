ARG TF_VERSION=${TERRAFORM_VERSION}

FROM hashicorp/terraform:${TF_VERSION}

RUN apk add --update --upgrade --no-cache bash git openssh
RUN apk upgrade libtasn1
RUN apk upgrade musl
RUN apk upgrade curl
RUN apk upgrade libgcrypt

ARG TERRAGRUNT_VERSION=${TERRAGRUNT_VERSION}

ADD https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 /usr/local/bin/terragrunt

RUN chmod +x /usr/local/bin/terragrunt

WORKDIR /apps

ENTRYPOINT ["/usr/local/bin/terragrunt"]
