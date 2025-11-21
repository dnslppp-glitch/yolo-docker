#!/usr/bin/env bash
set -e

# 엔트리포인트: 이미지 URL을 받아서 detect 실행
# 사용법: docker run --rm <repo>/yolo <IMAGE_URL>

# 저장 위치
WEIGHTS_DIR=/workspace/darknet
WEIGHTS_FILE=$WEIGHTS_DIR/yolov3.weights

# weights 파일이 없으면 다운로드
if [ ! -f "$WEIGHTS_FILE" ]; then
  echo "yolov3.weights가 없습니다. 다운로드를 시작합니다..."
  wget -O "$WEIGHTS_FILE" https://pjreddie.com/media/files/yolov3.weights
fi

# 인자 처리
if [ "$#" -eq 0 ]; then
  echo "Usage: docker run --rm <repo>/yolo <IMAGE_URL>"
  exec /bin/bash
fi

IMAGE_URL="$1"
FNAME=/tmp/input.jpg

# 이미지 다운로드
wget -q -O "$FNAME" "$IMAGE_URL"
if [ $? -ne 0 ]; then
  echo "이미지 다운로드 실패: $IMAGE_URL" >&2
  exit 2
fi

cd $WEIGHTS_DIR
# detector test를 실행하고 출력은 표준출력으로 전달
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights "$FNAME"

# predictions.jpg 파일이 생성됨 (이미지 출력은 과제상 필요 없음)
