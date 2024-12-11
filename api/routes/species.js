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
          attributes: ["name"],
          include: [
            {
              model: models.Family,
              as: "family",
              attributes: ["name"],
              include: [
                {
                  model: models.Order,
                  as: "order",
                  attributes: ["name"],
                  include: [
                    {
                      model: models.Class,
                      as: "class",
                      attributes: ["name"],
                      include: [
                        {
                          model: models.Phylum,
                          as: "phylum",
                          attributes: ["name"],
                          include: [{ model: models.Kingdom, as: "kingdom", attributes: ["name"] }],
                        },
                      ],
                    },
                  ],
                },
              ],
            },
          ],
        },
        {
          model: models.ConservationStatus,
          as: "conservationStatus",
          attributes: ["description", "severity", "name"],
        },
        {
          model: models.Characteristic,
          as: "characteristics",
          attributes: ["id", "characteristic_type", "value", "units"],
        },
        {
          model: models.Habitat,
          as: "habitats",
          through: { attributes: [] }, // Ẩn bảng trung gian
          attributes: ["id", "name", "description", "climate", "temperature", "humidity"],
        },
      ],
      attributes: ["id", "scientific_name", "common_name", "taxonomy_browser", "image_url", "createdAt"],
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
