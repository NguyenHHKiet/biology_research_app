# Các bước tạo Docker Image và Container

1. **Tạo Docker Image**:
   Trong thư mục chứa `Dockerfile`, chạy lệnh sau:

   ```bash
   docker build -t api-image .
   ```

2. **Chạy Container từ Image**:

   ```bash
   docker run -d -p 3000:3000 --name api-container api-image
   ```

   - `-d`: Chạy container ở chế độ nền.
   - `-p 3000:3000`: Map cổng 3000 của container ra cổng 3000 của máy host.

3. **Kiểm tra container đang chạy**:

   ```bash
   docker ps
   ```

4. **Truy cập ứng dụng**:
   Sau khi container được khởi động, bạn có thể truy cập API ở `http://localhost:3000`.

## Lưu ý khi làm việc với Docker

- **Biến môi trường**: Nếu bạn sử dụng biến môi trường (như thông tin cơ sở dữ liệu), hãy tạo một tệp `.env` và thêm nó vào `docker-compose` hoặc mount vào container.
- **Cơ sở dữ liệu**: Đảm bảo cơ sở dữ liệu được kết nối thông qua biến môi trường hoặc dịch vụ bên ngoài (VD: MySQL, PostgreSQL).
- **Docker Compose (nếu cần)**: Nếu bạn muốn kết hợp ứng dụng API với cơ sở dữ liệu, hãy sử dụng `docker-compose.yml`.

Hãy kiểm tra và thử chạy ứng dụng của bạn. Nếu gặp vấn đề, bạn có thể gửi thêm thông tin để tôi hỗ trợ!
