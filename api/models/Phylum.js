module.exports = (sequelize, DataTypes) => {
  const Phylum = sequelize.define(
    "Phylum",
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
      kingdom_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Kingdom",
          key: "id",
        },
      },
    },
    {
      tableName: "Phylum",
      timestamps: false,
    },
  );

  return Phylum;
};
