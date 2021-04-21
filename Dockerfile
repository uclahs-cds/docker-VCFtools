FROM blcdsdockerregistry/bl-base:1.0.0 AS builder

# Use conda to install tools and dependencies into /usr/local
ENV VCFTOOLS_VERSION=0.1.16
RUN conda create -qy -p /usr/local \
    -c bioconda \
    -c conda-forge \
    vcftools==${VCFTOOLS_VERSION} \
    perl-vcftools-vcf==${VCFTOOLS_VERSION} \
    tabix

# Deploy the target tools into a base image
FROM ubuntu:20.04
COPY --from=builder /usr/local /usr/local

LABEL maintainer="Tim Sanders <tsanders@mednet.ucla.edu>"