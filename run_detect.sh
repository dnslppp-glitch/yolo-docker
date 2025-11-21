#!/usr/bin/env bash
# 로컬에서 Docker 없이 darknet 빌드 후 테스트할 때 사용
# 사용법: ./run_detect.sh https://.../image.jpg
IMAGE_URL="$1"
if [ -z "$IMAGE_URL" ]; then
  echo "Usage: $0 <IMAGE_URL>"
  exit 1
fi

wget -O /tmp/input.jpg "$IMAGE_URL"
cd darknet
if [ ! -f yolov3.weights ]; then
  wget https://pjreddie.com/media/files/yolov3.weights
fi
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights /tmp/input.jpg
