const { Sequelize } = require("sequelize");

require("dotenv").config(); // Để load các biến môi trường từ file .env

// Lấy các thông tin kết nối từ biến môi trường hoặc mặc định
const DB_HOST = process.env.DB_HOST; // hoặc 'db' nếu bạn dùng Docker
const DB_USER = process.env.DB_USER;
const DB_PASSWORD = process.env.DB_PASSWORD;
const DB_NAME = process.env.DB_NAME;
const DB_DIALECT = process.env.DB_DIALECT; // Có thể là mysql, postgres, sqlite, ...
const DB_POOL = {
  max: 5,
  min: 0,
  acquire: 30000,
  idle: 10000,
};

// Khởi tạo Sequelize instance
const sequelize = new Sequelize(DB_NAME, DB_USER, DB_PASSWORD, {
  host: DB_HOST,
  dialect: DB_DIALECT,
  pool: DB_POOL,
  logging: process.env.NODE_ENV !== "development", // Log SQL queries trong môi trường development
  dialectOptions: {
    useUTC: false, // Disable UTC for timezone handling
  },
  timezone: "+07:00", // Cài đặt múi giờ cho Việt Nam (UTC +7)
});

module.exports = sequelize;
