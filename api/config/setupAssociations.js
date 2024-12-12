const setupAssociations = models => {
  const {
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
  } = models;

  // Phân cấp sinh học: Kingdom -> Phylum -> Class -> Order -> Family -> Genus -> Species
  Kingdom.hasMany(Phylum, { foreignKey: "kingdom_id", as: "phylums" });
  Phylum.belongsTo(Kingdom, { foreignKey: "kingdom_id", as: "kingdom" });

  Phylum.hasMany(Class, { foreignKey: "phylum_id", as: "classes" });
  Class.belongsTo(Phylum, { foreignKey: "phylum_id", as: "phylum" });

  Class.hasMany(Order, { foreignKey: "class_id", as: "orders" });
  Order.belongsTo(Class, { foreignKey: "class_id", as: "class" });

  Order.hasMany(Family, { foreignKey: "order_id", as: "families" });
  Family.belongsTo(Order, { foreignKey: "order_id", as: "order" });

  Family.hasMany(Genus, { foreignKey: "family_id", as: "genera" });
  Genus.belongsTo(Family, { foreignKey: "family_id", as: "family" });

  Genus.hasMany(Species, { foreignKey: "genus_id", as: "species" });
  Species.belongsTo(Genus, { foreignKey: "genus_id", as: "genus" });

  // Species <-> OrganismGroup (N-N)
  Species.belongsToMany(OrganismGroup, {
    through: OrganismGroupSpecies,
    foreignKey: "species_id",
    as: "organismGroups",
  });
  OrganismGroup.belongsToMany(Species, {
    through: OrganismGroupSpecies,
    foreignKey: "organism_group_id",
    as: "speciesInGroup",
  });

  // Species -> Characteristic (1-N)
  Species.hasMany(Characteristic, {
    foreignKey: "species_id",
    as: "characteristics",
  });
  Characteristic.belongsTo(Species, {
    foreignKey: "species_id",
    as: "species",
  });

  // Species <-> Habitat (N-N)
  Species.belongsToMany(Habitat, {
    through: SpeciesHabitat,
    foreignKey: "species_id",
    as: "habitats",
  });
  Habitat.belongsToMany(Species, {
    through: SpeciesHabitat,
    foreignKey: "habitat_id",
    as: "speciesInHabitat",
  });

  // Species -> GeographicDistribution (1-N)
  Species.hasMany(GeographicDistribution, {
    foreignKey: "species_id",
    as: "geographicDistributions",
  });
  GeographicDistribution.belongsTo(Species, {
    foreignKey: "species_id",
    as: "species",
  });

  // Author <-> Species (M-N) thông qua SpeciesAuthor
  Author.belongsToMany(Species, {
    through: SpeciesAuthor,
    foreignKey: "author_id",
    as: "speciesByAuthor",
  });
  Species.belongsToMany(Author, {
    through: SpeciesAuthor,
    foreignKey: "species_id",
    as: "authorsOfSpecies",
  });

  // ResearchRecord <-> Species (M-N) thông qua ResearchRecordAuthor
  ResearchRecord.belongsToMany(Author, {
    through: ResearchRecordAuthor,
    foreignKey: "research_record_id",
    as: "speciesInResearchRecord",
  });
  Author.belongsToMany(ResearchRecord, {
    through: ResearchRecordAuthor,
    foreignKey: "author_id",
    as: "researchRecords",
  });

  // ** Thiết lập quan hệ ConservationStatus và Species **
  ConservationStatus.belongsTo(Species, {
    foreignKey: "species_id",
    as: "species",
    onDelete: "CASCADE",
  });
  Species.hasOne(ConservationStatus, {
    foreignKey: "species_id",
    as: "conservationStatus",
  });

  // ** Thiết lập quan hệ ResearchSubject và ResearchRecord **
  ResearchSubject.hasMany(ResearchRecord, {
    foreignKey: "research_subject_id",
    as: "researchRecords",
  });
  ResearchRecord.belongsTo(ResearchSubject, {
    foreignKey: "research_subject_id",
    as: "researchSubject",
  });

  // Các quan hệ khác tùy thuộc vào yêu cầu của hệ thống
};

module.exports = setupAssociations;
