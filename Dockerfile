# 使用 Ubuntu 24.04 作为基础镜像
FROM ubuntu:24.04

# 设置非交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本工具
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 安装 Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /sdks/flutter \
    && cd /sdks/flutter \
    && git checkout stable \
    && /sdks/flutter/bin/flutter precache \
    && /sdks/flutter/bin/flutter doctor

# 安装 Android SDK
ENV ANDROID_HOME=/opt/android-sdk
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && curl -o commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip \
    && unzip commandlinetools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && mv ${ANDROID_HOME}/cmdline-tools/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest \
    && rm commandlinetools.zip \
    && yes | ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager --licenses \
    && ${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager "platform-tools" "build-tools;35.0.0" "platforms;android-35"

# 设置环境变量
ENV PATH=${PATH}:/sdks/flutter/bin:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools

# 验证 Flutter 环境
RUN flutter doctor

