# Cài đặt Hệ điều hành và các phụ thuộc
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback python3
RUN apt-get clean

ENV DEBIAN_FRONTEND=dialog
ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# Tải xuống Flutter SDK từ kho lưu trữ Github của Flutter
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Thiết lập đường dẫn môi trường Flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Chạy flutter doctor
RUN flutter doctor

# Bật tính năng Flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Sao chép các tệp vào container và xây dựng
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web

# Ghi lại cổng được mở
EXPOSE 9000

# Thiết lập tập lệnh khởi động server thành có thể thực thi và khởi động máy chủ web
RUN ["chmod", "+x", "/app/server/server.sh"]

ENTRYPOINT [ "/app/server/server.sh"]