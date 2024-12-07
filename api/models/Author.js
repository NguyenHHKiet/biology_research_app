module.exports = (sequelize, DataTypes) => {
  const Author = sequelize.define(
    "Author",
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
      affiliation: {
        type: DataTypes.STRING,
      },
    },
    {
      tableName: "Author",
      timestamps: false,
    },
  );

  return Author;
};
