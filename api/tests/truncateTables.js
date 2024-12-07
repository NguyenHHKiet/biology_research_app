const sequelize = require("../config/db");

(async () => {
  try {
    await sequelize.query('TRUNCATE TABLE "TableName1", "TableName2", "TableName3" RESTART IDENTITY CASCADE');
    console.log("✅ Đã xóa toàn bộ dữ liệu trong các bảng!");
  } catch (error) {
    console.error("❌ Lỗi khi xóa dữ liệu trong bảng:", error);
  } finally {
    await sequelize.close();
  }
})();
