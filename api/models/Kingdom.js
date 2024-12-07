module.exports = (sequelize, DataTypes) => {
  const Kingdom = sequelize.define(
    "Kingdom",
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
    },
    {
      tableName: "Kingdom",
      timestamps: false, // Nếu không cần trường createdAt, updatedAt
    },
  );

  return Kingdom;
};
