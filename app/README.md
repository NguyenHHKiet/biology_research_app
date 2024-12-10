# **Chạy ứng dụng Flutter**

1. **Mở project Flutter:**

   - Dùng Visual Studio Code, Android Studio, hoặc terminal.
   - Điều hướng đến thư mục chứa project Flutter (thường có file `pubspec.yaml`).

2. **Cài đặt dependencies:**

   - Chạy lệnh:

     ```bash
     flutter pub get
     ```

3. **Chạy app:**

   - **Chạy trên terminal:**

     ```bash
     flutter run
     ```

   - **Chạy qua Visual Studio Code:**
     - Mở file `main.dart`.
     - Nhấn `F5` hoặc chọn _Run > Start Debugging_.

4. **Chọn thiết bị chạy:**

   - Khi chạy lệnh `flutter devices`, bạn sẽ thấy danh sách các thiết bị khả dụng:

     ```bash
     flutter devices
     ```

   - Để chọn thiết bị cụ thể, dùng:

     ```bash
     flutter run -d <device_id>
     ```
