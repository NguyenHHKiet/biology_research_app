module.exports = (sequelize, DataTypes) => {
  const ConservationStatus = sequelize.define(
    "ConservationStatus",
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
        type: DataTypes.TEXT,
      },
      severity: {
        type: DataTypes.STRING,
      },
    },
    {
      tableName: "ConservationStatus",
      timestamps: false,
    },
  );

  return ConservationStatus;
};
