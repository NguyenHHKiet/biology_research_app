const express = require("express");
const router = express.Router();
const { createAuthor } = require("../controllers/author");

// Route to create a new author
router.route("/").post(createAuthor);

module.exports = router;
