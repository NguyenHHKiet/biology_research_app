const express = require("express");
const router = express.Router();
const { models } = require("../models");

// Endpoint: Lấy danh sách species
router.get("/", async (req, res) => {
  try {
    const speciesList = await models.Species.findAll({
      include: [
        { model: models.Genus, as: "genus" },
        { model: models.OrganismGroup, as: "organismGroups" },
        { model: models.Habitat, as: "habitats" },
        { model: models.GeographicDistribution, as: "geographicDistributions" },
      ],
    });
    res.json(speciesList);
  } catch (error) {
    console.error("Error fetching species:", error);
    res.status(500).json({ error: "An error occurred while fetching species." });
  }
});

module.exports = router;
