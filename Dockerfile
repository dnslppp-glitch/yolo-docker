# Dockerfile: Darknet + YOLOv3
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace

# 필수 패키지 설치
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    ca-certificates \
    libopencv-dev \
    pkg-config \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libavformat-dev \
    libswscale-dev \
    python3 \
    python3-pip \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Darknet 소스코드 클론
RUN git clone https://github.com/pjreddie/darknet.git /workspace/darknet
WORKDIR /workspace/darknet

# Makefile: OpenCV 사용 설정 (옵션)
RUN sed -i 's/OPENCV=0/OPENCV=1/' Makefile \
 && sed -i 's/GPU=0/GPU=0/' Makefile \
 && sed -i 's/CUDNN=0/CUDNN=0/' Makefile

# 빌드
RUN make -j$(nproc)

# 작업 디렉토리로 스크립트 복사
WORKDIR /workspace
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY run_detect.sh /usr/local/bin/run_detect.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh /usr/local/bin/run_detect.sh

# 기본 포인트
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["--help"]
