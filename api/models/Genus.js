module.exports = (sequelize, DataTypes) => {
  const Genus = sequelize.define(
    "Genus",
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
      family_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Family",
          key: "id",
        },
      },
    },
    {
      tableName: "Genus",
      timestamps: false,
    },
  );

  return Genus;
};
