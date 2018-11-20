FROM alpine:latest

# ----------------------------------------
# # Buildingtool Install
# ----------------------------------------
RUN apk add --update git curl openssh bash

# ----------------------------------------
# Terraform Install
# refs: https://github.com/hashicorp/docker-hub-images/blob/master/terraform/Dockerfile-light
# refs: https://www.terraform.io/downloads.html
# ----------------------------------------
ARG TERRAFORM_VERSION=0.11.10
ARG TERRAFORM_SHA256SUM=43543a0e56e31b0952ea3623521917e060f2718ab06fe2b2d506cfaa14d54527

RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
	echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
	sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
	rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
	rm -f terraform_${TERRAFORM_VERSION}_SHA256SUMS

# ----------------------------------------
# tfnotify Install
# refs: https://github.com/mercari/tfnotify/releases
# ----------------------------------------
ARG TFNOTIFY_VERSION=v0.2.0
RUN curl -sLJO https://github.com/mercari/tfnotify/releases/download/${TFNOTIFY_VERSION}/tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz > tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz && \
	tar -xf tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz && \
	mv tfnotify_${TFNOTIFY_VERSION}_linux_amd64/tfnotify /bin/tfnotify && \
	rm -f tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz && \
	rm -rf tfnotify_${TFNOTIFY_VERSION}_linux_amd64

