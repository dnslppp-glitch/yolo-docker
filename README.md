# YOLOv3 Docker (과제 #1 제출용)

이 레포지토리는 Darknet 기반 YOLOv3를 Docker 이미지로 패키징한 예제입니다.

## 요구사항
- Docker가 설치되어 있어야 합니다.
- 인터넷 연결이 필요합니다 (yolov3.weights 다운로드 등).

## 빌드 및 실행
1. Docker 이미지 빌드

```bash
docker build -t <DOCKERHUB_USERNAME>/yolo:latest .
```

2. Docker Hub에 로그인

```bash
docker login
```

3. Docker 이미지 푸시

```bash
docker push <DOCKERHUB_USERNAME>/yolo:latest
```

4. 실행 예시

```bash
docker run --rm <DOCKERHUB_USERNAME>/yolo https://upload.wikimedia.org/wikipedia/commons/3/3b/SBB_Re_450_097_ZKB_Nachtnetz.jpg
```

실행하면 darknet이 yolov3.weights를 (없다면) 다운로드하고 입력 이미지에 대해 예측 결과를 표준출력으로 표시합니다.

## GitHub 제출
- Dockerfile을 포함한 레포지토리 전체를 GitHub에 푸시하세요.
- Docker Hub 이미지 링크(예: `docker.io/<DOCKERHUB_USERNAME>/yolo:latest`)를 제출하세요.

## 노트
- 이 Dockerfile은 GPU/CUDNN을 사용하지 않는 CPU 전용 구성입니다. GPU를 사용하려면 CUDA 베이스 이미지로 시작하고 Makefile의 GPU/CUDNN 옵션을 활성화해야 합니다.
- `yolov3.weights` 파일 크기가 매우 크므로 Docker 이미지에 직접 포함시키지 않고, 컨테이너 시작 시 다운로드하도록 설계했습니다.
