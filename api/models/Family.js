module.exports = (sequelize, DataTypes) => {
  const Family = sequelize.define(
    "Family",
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
      order_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Order",
          key: "id",
        },
      },
    },
    {
      tableName: "Family",
      timestamps: false,
    },
  );

  return Family;
};
