module.exports = (sequelize, DataTypes) => {
  const SpeciesHabitat = sequelize.define(
    "SpeciesHabitat",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      species_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Species",
          key: "id",
        },
      },
      habitat_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Habitat",
          key: "id",
        },
      },
    },
    {
      tableName: "SpeciesHabitat",
      timestamps: false,
    },
  );

  return SpeciesHabitat;
};
