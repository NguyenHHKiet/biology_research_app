#!/bin/bash

# Định nghĩa port
PORT=9000

# Kiểm tra xem port có đang được sử dụng không và giải phóng nếu cần
echo "Đang kiểm tra xem cổng $PORT có đang được sử dụng không..."
if [ "$(lsof -t -i :$PORT)" ]; then
  echo "Cổng $PORT đang được sử dụng. Dừng tiến trình đang chạy trên cổng này..."
  fuser -k -n tcp $PORT
fi

# Chuyển đến thư mục build web của ứng dụng
cd /app/build/web/

# Khởi động server trên cổng được chỉ định
echo "Khởi động server trên cổng $PORT..."
python3 -m http.server $PORT
