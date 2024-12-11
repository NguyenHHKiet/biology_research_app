const asyncHandler = require("../middleware/async");
const {
  models: { Species },
} = require("../models");

// @desc    Get all species
// @route   GET /api/v1/species
// @access  Public
// @query single    ?common_name=...
// @query filter    ?select=name,...&sort=-name
// @pagination      ?page=2&limit=10
exports.getAllSpecies = asyncHandler(async (req, res) => {
  res.status(200).json(res.advancedResults);
});

// @desc    Get single species
// @route   GET /api/v1/species/:id
// @access  Public
exports.getSingleSpecies = asyncHandler(async (req, res) => {
  const species = await Species.findById(req.params.id);

  if (!species) {
    return res.status(404).json({
      success: false,
      message: `Species not found with id of ${req.params.id}`,
    });
  }

  res.status(200).json({
    success: true,
    data: species,
  });
});

// @desc    Create new species
// @route   POST /api/v1/species
// @access  Private
exports.createSpecies = asyncHandler(async (req, res) => {
  const species = await Species.create(req.body);

  res.status(201).json({
    success: true,
    data: species,
  });
});

// @desc    Update species
// @route   PUT /api/v1/species/:id
// @access  Private
exports.updateSpecies = asyncHandler(async (req, res) => {
  const species = await Species.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
    runValidators: true,
  });

  if (!species) {
    return res.status(404).json({
      success: false,
      message: `Species not found with id of ${req.params.id}`,
    });
  }

  res.status(200).json({
    success: true,
    data: species,
  });
});

// @desc    Delete species
// @route   DELETE /api/v1/species/:id
// @access  Private
exports.deleteSpecies = asyncHandler(async (req, res) => {
  const species = await Species.findByIdAndDelete(req.params.id);

  if (!species) {
    return res.status(404).json({
      success: false,
      message: `Species not found with id of ${req.params.id}`,
    });
  }

  res.status(200).json({
    success: true,
    data: {},
  });
});
