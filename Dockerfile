FROM openjdk:11-slim-buster

LABEL version="1.0" \
      maintainer="toliyansky@gmail.com" \
      description="Image for building android applications"

RUN apt update && apt install -y wget unzip

# Download and install Android SDK
# https://developer.android.com/studio/#downloads
ARG ANDROID_SDK_VERSION=4333796
ENV ANDROID_HOME /opt/android-sdk
RUN mkdir -p ${ANDROID_HOME} && cd ${ANDROID_HOME} && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip && \
    unzip *tools*linux*.zip && \
    rm *tools*linux*.zip

# Accept the license agreements of the SDK components
ADD license_accepter.sh /opt/
RUN chmod +x /opt/license_accepter.sh && /opt/license_accepter.sh $ANDROID_HOME