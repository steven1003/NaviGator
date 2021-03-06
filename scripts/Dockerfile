# This Docker file generates an image based on Ubuntu 16.04 and installs the
# packages required for use with Jenkins CI. It uses the install script to
# configure the image for building NaviGator.

FROM ubuntu:xenial

MAINTAINER Steven Spinner <stevenmspin1003@gmail.com>

# Configure the install script for NaviGator with CUDA
ENV DOCKER true
ENV INSTALL_NAV true
ENV INSTALL_CUDA true
ENV INSTALL_FLYCAP true

# Allow the user to pass in the SDK password with '--build-arg SDK_PASSWORD="password"'
ARG SDK_PASSWORD

# Update the image and install tools needed to create the image
RUN DEBIAN_FRONTEND=noninteractive apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y install sudo \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y install curl \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y install wget \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y install lightdm \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y autoremove --purge \
	&& apt-get -y clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -f /var/cache/apt/*.bin


# Create a gitlab user for GitLab CI and grant it passwordless sudo access
RUN useradd --uid 10000 --create-home --shell /bin/bash gitlab \
	&& echo "" >> /etc/sudoers \
	&& echo "gitlab ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Make GitLab the default user for the image
USER gitlab
WORKDIR /home/gitlab
SHELL ["/bin/bash", "-c"]

# Run the install script in Docker mode (with the DOCKER environment variable)
RUN wget https://raw.githubusercontent.com/steven1003/installer/master/install.sh \
	&& chmod +x install.sh \
	&& bash install.sh \
	&& rm install.sh \
	&& sudo apt-get -y clean \
	&& sudo rm -rf /var/lib/apt/lists/* \
	&& sudo rm -f /var/cache/apt/*.bin
