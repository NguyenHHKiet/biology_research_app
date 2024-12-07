module.exports = (sequelize, DataTypes) => {
  const Order = sequelize.define(
    "Order",
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
      class_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Class",
          key: "id",
        },
      },
    },
    {
      tableName: "Order",
      timestamps: false,
    },
  );

  return Order;
};
