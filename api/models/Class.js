module.exports = (sequelize, DataTypes) => {
  const Class = sequelize.define(
    "Class",
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
      phylum_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Phylum",
          key: "id",
        },
      },
    },
    {
      tableName: "Class",
      timestamps: false,
    },
  );

  return Class;
};
