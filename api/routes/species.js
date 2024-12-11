const express = require("express");
const {
  getAllSpecies,
  getSingleSpecies,
  createSpecies,
  updateSpecies,
  deleteSpecies,
} = require("../controllers/species");

const { models } = require("../models");
const advancedResults = require("../middleware/advancedResults");

const router = express.Router();

// Public routes
router
  .route("/")
  .get(
    advancedResults(models.Species, {
      include: [
        {
          model: models.Genus,
          as: "genus",
          attributes: ["id", "name"],
        },
        {
          model: models.ConservationStatus,
          as: "conservationStatus",
          attributes: ["id", "description"],
        },
      ],
    }),
    getAllSpecies,
  ) // Get all species
  .post(createSpecies); // Create new species (Private)

router
  .route("/:id")
  .get(getSingleSpecies) // Get single species
  .put(updateSpecies) // Update species (Private)
  .delete(deleteSpecies); // Delete species (Private)

module.exports = router;
