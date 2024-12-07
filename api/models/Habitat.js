module.exports = (sequelize, DataTypes) => {
  const Habitat = sequelize.define(
    "Habitat",
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
      description: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      climate: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      temperature: {
        type: DataTypes.FLOAT,
        allowNull: true,
      },
      humidity: {
        type: DataTypes.FLOAT,
        allowNull: true,
      },
    },
    {
      tableName: "Habitat",
      timestamps: false,
    },
  );

  return Habitat;
};
