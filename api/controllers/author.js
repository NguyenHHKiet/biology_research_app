const {
  model: { Author },
} = require("../models");

// * Create a new author based on data from Firebase.
module.exports.createAuthor = async (req, res) => {
  try {
    // Extract data from the request body
    const { name, affiliation } = req.body;

    // Ensure "name" is provided
    if (!name) {
      return res.status(400).json({ message: "Name is required." });
    }

    // Create the author in the database
    const newAuthor = await Author.create({ name, affiliation });

    // Respond with the created author
    return res.status(201).json(newAuthor);
  } catch (error) {
    console.error("Error creating author:", error);
    return res.status(500).json({ message: "Internal server error." });
  }
};
