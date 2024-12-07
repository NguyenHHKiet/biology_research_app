module.exports = (sequelize, DataTypes) => {
  const OrganismGroupSpecies = sequelize.define(
    "OrganismGroupSpecies",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      organism_group_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "OrganismGroup",
          key: "id",
        },
      },
      species_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Species",
          key: "id",
        },
      },
    },
    {
      tableName: "OrganismGroupSpecies",
      timestamps: false,
    },
  );

  return OrganismGroupSpecies;
};
