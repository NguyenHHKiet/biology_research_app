module.exports = (sequelize, DataTypes) => {
  const GeographicDistribution = sequelize.define(
    "GeographicDistribution",
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
      region: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      country: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      location: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      notes: {
        type: DataTypes.TEXT,
        allowNull: true,
      },
    },
    {
      tableName: "GeographicDistribution",
      timestamps: false,
    },
  );

  return GeographicDistribution;
};
