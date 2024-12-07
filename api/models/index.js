const Sequelize = require("sequelize");
const sequelize = require("../config/db"); // Kết nối Sequelize

// Import các mô hình
const Kingdom = require("./Kingdom")(sequelize, Sequelize.DataTypes);
const Phylum = require("./Phylum")(sequelize, Sequelize.DataTypes);
const Class = require("./Class")(sequelize, Sequelize.DataTypes);
const Order = require("./Order")(sequelize, Sequelize.DataTypes);
const Family = require("./Family")(sequelize, Sequelize.DataTypes);
const Genus = require("./Genus")(sequelize, Sequelize.DataTypes);
const Species = require("./Species")(sequelize, Sequelize.DataTypes);
const OrganismGroup = require("./OrganismGroup")(sequelize, Sequelize.DataTypes);
const OrganismGroupSpecies = require("./OrganismGroupSpecies")(sequelize, Sequelize.DataTypes);
const Characteristic = require("./Characteristic")(sequelize, Sequelize.DataTypes);
const Habitat = require("./Habitat")(sequelize, Sequelize.DataTypes);
const SpeciesHabitat = require("./SpeciesHabitat")(sequelize, Sequelize.DataTypes);
const GeographicDistribution = require("./GeographicDistribution")(sequelize, Sequelize.DataTypes);
const Author = require("./Author")(sequelize, Sequelize.DataTypes);
const ConservationStatus = require("./ConservationStatus")(sequelize, Sequelize.DataTypes);
const ResearchRecord = require("./ResearchRecord")(sequelize, Sequelize.DataTypes);
const ResearchRecordAuthor = require("./ResearchRecordAuthor")(sequelize, Sequelize.DataTypes);
const ResearchSubject = require("./ResearchSubject")(sequelize, Sequelize.DataTypes);
const SpeciesAuthor = require("./SpeciesAuthor")(sequelize, Sequelize.DataTypes);

// Lưu tất cả các mô hình vào object
const models = {
  Kingdom,
  Phylum,
  Class,
  Order,
  Family,
  Genus,
  Species,
  OrganismGroup,
  OrganismGroupSpecies,
  Characteristic,
  Habitat,
  SpeciesHabitat,
  GeographicDistribution,
  Author,
  ConservationStatus,
  ResearchRecord,
  ResearchRecordAuthor,
  ResearchSubject,
  SpeciesAuthor,
};

// Export Sequelize instance và models
module.exports = { sequelize, models };
