module.exports = (sequelize, DataTypes) => {
  const Species = sequelize.define(
    "Species",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      scientific_name: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      common_name: {
        type: DataTypes.STRING,
      },
      genus_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Genus",
          key: "id",
        },
      },
      conservation_status_id: {
        type: DataTypes.INTEGER,
        references: {
          model: "ConservationStatus",
          key: "id",
        },
      },
      image_url: {
        type: DataTypes.STRING,
      },
      taxonomy_browser: {
        type: DataTypes.STRING,
      },
    },
    {
      tableName: "Species",
      timestamps: true,
    },
  );

  return Species;
};
