module.exports = (sequelize, DataTypes) => {
  const OrganismGroup = sequelize.define(
    "OrganismGroup",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      name: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      symbol: {
        type: DataTypes.STRING,
        allowNull: true,
      },
    },
    {
      tableName: "OrganismGroup",
      timestamps: false,
    },
  );

  return OrganismGroup;
};
