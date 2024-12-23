# Xây Dựng Ứng Dụng Nghiêm Cứu Biology Research App

Dưới đây là tệp `docker-compose.yml` để triển khai cả hai dự án `api` (Node.js backend) và `app` (Flutter frontend mobile). Tệp này giúp bạn đồng bộ hóa việc xây dựng, chạy container, và liên kết hai dịch vụ với nhau.

## 1. Entity Relationship (ER) Diagram

Biểu đồ quan hệ thực thể (ER) là một loại sơ đồ luồng minh họa cách các “thực thể” như con người, đối tượng hoặc khái niệm liên quan đến nhau trong một hệ thống.

![image](./assets/images/Tổng%20Hợp%20Kiến%20Thức%20Sinh%20Vật%20Học.drawio.png)

## 2. Cập nhật file `.env`

Cần một số lưu ý khi bạn build trong môi trường docker, bạn phải tạo file `.env` để trỏ tới các biến được cấu hình:

- **Môi trường docker:** bạn phải tạo `.env` ở root cho `docker-compose.yml`.
- **Môi trường development:** bạn sẽ tạo riêng `.env` cho từng project.
- **Lưu ý:** bạn sử dụng pgAdmin trên máy tính thì DB_HOST là `localhost`, hoặc `db` khi sử dụng postgres docker.

Đảm bảo các biến môi trường (`API_PORT`, `FLUTTER_PORT`, `DB_USER`, `DB_PASSWORD`, v.v.) được định nghĩa đầy đủ và đúng giá trị trong file `.env`.

```bash
# API Configuration
API_PORT= # Cổng mà API sẽ chạy (mặc định là `3000`).
API_URL= # URL gốc của API (mặc định là `http://localhost:3000`).

# Database Configuration
DB_NAME= # Tên cơ sở dữ liệu
DB_USER= # Tên người dùng để kết nối đến cơ sở dữ liệu.
DB_PASSWORD= # Mật khẩu của người dùng cơ sở dữ liệu.
DB_HOST= # Host của cơ sở dữ liệu (nếu sử dụng Docker, giá trị là `db`, ngược lại là `localhost`).
DB_PORT= # Cổng để kết nối cơ sở dữ liệu (mặc định là `5432`).
DB_DIALECT= # Loại cơ sở dữ liệu (mặc định là `postgres`).

# Environment
NODE_ENV= # Môi trường chạy của Node.js (`development`, `staging`, `production`).

# Flutter Configuration
FLUTTER_PORT= # Cổng chạy ứng dụng Flutter (mặc định là `9000`).
FLUTTER_PORT_MOBILE= # Cổng dành cho thiết bị di động (mặc định là `5555`).
API_KEY= # Khóa API dùng cho Firebase.
APP_ID= # ID ứng dụng Firebase.
MESSAGING_SENDER_ID= # ID người gửi Firebase Cloud Messaging.
STORAGE_BUCKET= # URL bucket của Firebase Storage.
PROJECT_ID= # ID dự án Firebase.

# Other Configurations
SEED_DB= # Cờ cho biết có cần khởi tạo dữ liệu mẫu trong cơ sở dữ liệu hay không (`true` hoặc `false`).
```

## 3. Build và chạy container

1. **Build Docker Compose:**
   Khi mọi thứ đã được thiết lập, bạn có thể chạy Docker Compose như sau:

   ```bash
   docker-compose up --build
   ```

   **Dùng BuildKit cho hiệu năng tốt hơn**

   BuildKit là engine mới của Docker giúp cải thiện hiệu năng build và caching:

   ```bash
   DOCKER_BUILDKIT=1 docker-compose build --progress=plain
   ```

   Docker Compose sẽ tự động tải các biến môi trường từ file `.env` vào các container và bắt đầu các dịch vụ của bạn (API, Flutter app và PostgreSQL). Nếu bạn thực hiện các bước trên, lần build tiếp theo sẽ nhanh hơn rất nhiều do Docker tận dụng cache hiệu quả! Thêm flag `--progress=plain` để kiểm tra liệu cache có được sử dụng đúng cách hay không:

2. **Kiểm tra kết nối tới PostgresSQL:** Mở một shell trong container `api` và xác minh kết nối bằng lệnh Sequelize:

   ```bash
    docker exec -it <api_container_name> bash
    node
    > const sequelize = require('./api/config/db.js'); // Đảm bảo đúng đường dẫn
    > sequelize.authenticate()
        .then(() => console.log('Kết nối thành công!'))
        .catch(err => console.error('Lỗi kết nối:', err));
   ```

## 4. Quản lý cơ sở dữ liệu

- **Kết nối trực tiếp đến PostgreSQL từ máy host:**

  ```bash
   psql -h localhost -U postgres -d biology_research
  ```

  Sử dụng thông tin trong `.env` (DB_USER, DB_PASSWORD, DB_NAME).

- **Khởi tạo hoặc chạy migration bằng Sequelize CLI:**

  ```bash
    # Cài đặt Sequelize CLI trong api
    npm install --save-dev sequelize-cli
    # Tạo các migration file
    npx sequelize-cli migration:generate --name init-schema
    # Chạy migration:
    npx sequelize-cli db:migrate
  ```

## 5. Cải tiến đề xuất

1. **Tích hợp CI/CD:**

   - Sử dụng GitHub Actions hoặc GitLab CI/CD để tự động hóa quá trình build và deploy.
   - Ví dụ: chạy lệnh `docker-compose up` khi đẩy code lên nhánh chính.

2. **Thêm Reverse Proxy:**

   - Sử dụng Nginx hoặc Traefik làm reverse proxy để quản lý routing giữa `api` và `app`.
   - Ví dụ: cấu hình Nginx để chuyển tiếp các yêu cầu `/api` tới backend và phần còn lại tới frontend.

3. **Logging và Monitoring:**

   - Thêm dịch vụ như ELK stack (Elasticsearch, Logstash, Kibana) hoặc Prometheus & Grafana để theo dõi logs và hiệu suất hệ thống.

4. **Caching:**

   - Sử dụng Redis để caching dữ liệu nhằm cải thiện hiệu năng backend.

5. **Dockerize môi trường phát triển:**

   - Tạo file `docker-compose.override.yml` để cấu hình môi trường dev với hot reload (chẳng hạn thêm lệnh `nodemon` cho backend và `flutter run` cho frontend).

6. **Triển khai Kubernetes (nếu cần mở rộng):**
   - Sau khi hệ thống ổn định, bạn có thể triển khai các dịch vụ lên Kubernetes để mở rộng quy mô.
