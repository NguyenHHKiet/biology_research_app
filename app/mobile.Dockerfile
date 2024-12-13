# Sử dụng hình ảnh nền Ubuntu với Flutter đã cài đặt sẵn
FROM biology_research_app-app:latest

# Copy code ứng dụng vào container
WORKDIR /app
COPY . .

# Cài đặt các phụ thuộc của ứng dụng
RUN flutter pub get

# Xây dựng ứng dụng cho Android và iOS
RUN flutter build apk
RUN flutter build ios

# (Tùy chọn) Nếu bạn muốn chạy các test
# RUN flutter test

# Tạo một điểm vào để chạy ứng dụng (ví dụ: chạy ứng dụng Android)
CMD ["flutter", "run", "-d", " emulator"]