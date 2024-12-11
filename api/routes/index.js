const express = require("express");
const speciesRoutes = require("./species");
const authorRoutes = require("./author");

const router = express.Router();

// Định tuyến các endpoint chính
router.use("/species", speciesRoutes); // Các endpoint liên quan đến species
router.use("/authors", authorRoutes); // Các endpoint liên quan đến authors

module.exports = router;
