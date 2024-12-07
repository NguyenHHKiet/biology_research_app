const express = require("express");
const bodyParser = require("body-parser");
const morgan = require("morgan");
const { sequelize, models } = require("./models"); // Import Sequelize instance và tất cả các models
const setupAssociations = require("./config/setupAssociations"); // Hàm thiết lập associations
const seedDatabase = require("./config/seed"); // Hàm seed dữ liệu mẫu
require("dotenv").config(); // Để load các biến môi trường từ file .env

// Khởi tạo ứng dụng Express
const app = express();
const PORT = process.env.API_PORT || 4040;

// Middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(morgan("dev"));

// Endpoint gốc để kiểm tra server
app.get("/", (req, res) => {
  res.send("Welcome to the Biology Database API!");
});

// Import và thiết lập các routes
const speciesRoutes = require("./routes/speciesRoutes");
app.use("/species", speciesRoutes); // Tất cả endpoint liên quan đến species

// Hàm khởi động server và thiết lập database
const startServer = async () => {
  try {
    console.log("Starting server...");

    // Kết nối tới database
    console.log("Connecting to database...");
    await sequelize.authenticate();
    console.log("Database connected successfully!");

    // Thiết lập associations
    console.log("Setting up associations...");
    setupAssociations(models);

    // Đồng bộ database (sync tables)
    console.log("Synchronizing database...");
    if (process.env.NODE_ENV === "development") {
      await sequelize.sync({ alter: true }); // Sử dụng alter trong môi trường phát triển
    } else {
      await sequelize.sync(); // Không sử dụng alter trong production
    }

    // Seed dữ liệu mẫu nếu cần
    if (process.env.SEED_DB === "true") {
      console.log("Seeding database...");
      await seedDatabase();
    }

    // Khởi chạy server
    app.listen(PORT, () => {
      console.log(`Server is running at http://localhost:${PORT}`);
    });
  } catch (error) {
    console.error("Error starting server:", error);
    process.exit(1); // Kết thúc tiến trình nếu có lỗi
  }
};

// Xử lý ngắt kết nối an toàn khi server dừng
const handleShutdown = async () => {
  console.log("\nShutting down server...");
  if (sequelize) {
    await sequelize.close();
    console.log("Database connection closed.");
  }
  process.exit(0);
};

// Lắng nghe sự kiện ngắt kết nối
process.on("SIGINT", handleShutdown);
process.on("SIGTERM", handleShutdown);

// Gọi hàm khởi động server
startServer();
