module.exports = (sequelize, DataTypes) => {
  const Characteristic = sequelize.define(
    "Characteristic",
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
      characteristic_type: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      value: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      units: {
        type: DataTypes.STRING,
        allowNull: true,
      },
    },
    {
      tableName: "Characteristic",
      timestamps: false,
    },
  );

  return Characteristic;
};
