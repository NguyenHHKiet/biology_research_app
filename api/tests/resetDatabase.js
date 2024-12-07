const sequelize = require("../config/db"); // Import sequelize instance

(async () => {
  try {
    // Đồng bộ models với tuỳ chọn xoá database
    await sequelize.sync({ force: true }); // Dùng `force: true` để xoá tất cả bảng và tạo lại
    console.log("✅ Database đã được reset thành công!");
  } catch (error) {
    console.error("❌ Lỗi khi reset database:", error);
  } finally {
    // Đóng kết nối
    await sequelize.close();
  }
})();
