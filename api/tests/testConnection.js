const sequelize = require("../config/db"); // Đường dẫn tới file db.js của bạn

(async () => {
  try {
    // Kiểm tra kết nối
    await sequelize.authenticate();
    console.log("✅ Kết nối cơ sở dữ liệu thành công!");
  } catch (error) {
    console.error("❌ Không thể kết nối tới cơ sở dữ liệu:", error);
  } finally {
    // Đóng kết nối sau khi thử nghiệm
    await sequelize.close();
  }
})();
