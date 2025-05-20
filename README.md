# flutter-docker
Flutter Docker for Creating Apps


清理旧容器和卷：
移除旧容器和卷，避免缓存干扰：
bash

docker compose down -v

构建并启动：
bash

docker compose up --build -d

进入容器：
bash

docker exec -it flutter_dev bash

验证环境：
bash

flutter doctor
flutter --version

预期：
flutter doctor 显示 Flutter 3.32.0，stable 渠道，Android 工具链 [✓]。

flutter --version 确认 stable 渠道。

验证项目和编译：
bash

pwd
ls /app
flutter pub get
flutter build apk --debug
ls /app/build/app/outputs/flutter-apk/

pwd 应为 /app。

ls /app 应包含 pubspec.yaml、lib/ 等。

flutter build apk --debug 应生成 app-debug.apk。

