module.exports = (sequelize, DataTypes) => {
  const SpeciesAuthor = sequelize.define(
    "SpeciesAuthor",
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
      author_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Author",
          key: "id",
        },
      },
    },
    {
      tableName: "SpeciesAuthor",
      timestamps: false,
    },
  );

  return SpeciesAuthor;
};
