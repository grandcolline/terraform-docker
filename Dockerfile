FROM alpine:latest

# ----------------------------------------
# Buildingtool Install
# ----------------------------------------
RUN apk add --update git curl openssh bash

# ----------------------------------------
# Terraform Install
# refs: https://github.com/hashicorp/docker-hub-images/blob/master/terraform/Dockerfile-light
# refs: https://www.terraform.io/downloads.html
# ----------------------------------------
ARG TERRAFORM_VERSION=0.12.0
ARG TERRAFORM_SHA256SUM=42ffd2db97853d5249621d071f4babeed8f5fdba40e3685e6c1013b9b7b25830
RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
	echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
	sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
	unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
	rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip &&\
	rm -f terraform_${TERRAFORM_VERSION}_SHA256SUMS

# ----------------------------------------
# Tfnotify Install
# refs: https://github.com/mercari/tfnotify/releases
# ----------------------------------------
ARG TFNOTIFY_VERSION=v0.3.0
RUN curl -sLJ https://github.com/mercari/tfnotify/releases/download/${TFNOTIFY_VERSION}/tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz > tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz && \
	tar -xf tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz && \
	mv tfnotify_${TFNOTIFY_VERSION}_linux_amd64/tfnotify /bin/tfnotify && \
	rm -f tfnotify_${TFNOTIFY_VERSION}_linux_amd64.tar.gz && \
	rm -rf tfnotify_${TFNOTIFY_VERSION}_linux_amd64

# ----------------------------------------
# Tflint Install
# refs: https://github.com/wata727/tflint/releases
# ----------------------------------------
ARG TFLINT_VERSION=v0.8.1
RUN curl -L -o tflint.zip https://github.com/wata727/tflint/releases/download/${TFLINT_VERSION}/tflint_linux_amd64.zip && \
	unzip tflint.zip -d /usr/local/bin && \
	rm -f tflint.zip

