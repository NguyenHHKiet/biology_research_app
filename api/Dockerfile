# Giai đoạn 1: Xây dựng các phụ thuộc
FROM node:18-alpine AS build

# Thiết lập thư mục làm việc
WORKDIR /usr/src/app

# Sao chép các tệp package đầu tiên để tận dụng bộ nhớ đệm Docker
COPY package*.json ./

# Cài đặt các phụ thuộc
# Sử dụng npm ci để cài đặt phụ thuộc đáng tin cậy hơn trong môi trường sản xuất
RUN npm ci --only=production

# Giai đoạn 2: Môi trường sản xuất
FROM node:18-alpine

# Thiết lập thư mục làm việc
WORKDIR /usr/src/app

# Cài đặt chỉ các phụ thuộc sản xuất
COPY --from=build /usr/src/app/node_modules ./node_modules

# Sao chép các tệp ứng dụng
COPY . .

# Xóa các tệp phát triển hoặc không cần thiết
RUN rm -rf test .git .gitignore

# Tạo một người dùng không phải root để tăng cường bảo mật
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Thay đổi quyền sở hữu của thư mục ứng dụng
RUN chown -R appuser:appgroup /usr/src/app

# Chuyển đổi sang người dùng không phải root
USER appuser

# Tiếp xúc cổng mà ứng dụng chạy trên đó
EXPOSE ${API_PORT}

# Thiết lập môi trường thành sản xuất
ENV NODE_ENV=production

# Kiểm tra sức khỏe (tùy chọn)
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:${API_PORT}/health || exit 1

# Lệnh để chạy ứng dụng
CMD ["npm", "start"]