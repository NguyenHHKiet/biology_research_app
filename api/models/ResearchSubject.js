module.exports = (sequelize, DataTypes) => {
  const ResearchSubject = sequelize.define(
    "ResearchSubject",
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
      project: {
        type: DataTypes.STRING,
      },
      description: {
        type: DataTypes.TEXT,
      },
      start_date: {
        type: DataTypes.DATE,
      },
      end_date: {
        type: DataTypes.DATE,
      },
      status: {
        type: DataTypes.STRING,
      },
      team_members: {
        type: DataTypes.INTEGER,
      },
      budget: {
        type: DataTypes.FLOAT,
      },
    },
    {
      tableName: "ResearchSubject",
      timestamps: false,
    },
  );

  return ResearchSubject;
};
