const sequelize = require("../config/db");

(async () => {
  try {
    // Lấy danh sách tất cả các bảng trong cơ sở dữ liệu
    const result = await sequelize.query(`
      SELECT table_name
      FROM information_schema.tables
      WHERE table_schema = 'public'
    `);

    const tables = result[0].map(row => `"${row.table_name}"`);

    if (tables.length === 0) {
      console.log("❌ Không tìm thấy bảng nào trong cơ sở dữ liệu.");
      return;
    }

    // Tạo câu lệnh TRUNCATE
    const query = `TRUNCATE TABLE ${tables.join(", ")} RESTART IDENTITY CASCADE;`;

    // Thực thi TRUNCATE
    await sequelize.query(query);

    console.log("✅ Đã xóa toàn bộ dữ liệu trong các bảng!");
  } catch (error) {
    console.error("❌ Lỗi khi xóa dữ liệu trong bảng:", error);
  } finally {
    // Đóng kết nối database
    await sequelize.close();
    console.log("🔒 Kết nối cơ sở dữ liệu đã đóng.");
  }
})();
