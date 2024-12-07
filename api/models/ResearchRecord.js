module.exports = (sequelize, DataTypes) => {
  const ResearchRecord = sequelize.define(
    "ResearchRecord",
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
      research_date: {
        type: DataTypes.DATE,
      },
      description: {
        type: DataTypes.TEXT,
      },
      notes: {
        type: DataTypes.TEXT,
      },
      result: {
        type: DataTypes.STRING,
      },
      research_subject_id: {
        type: DataTypes.INTEGER,
        references: {
          model: "ResearchSubject",
          key: "id",
        },
      },
    },
    {
      tableName: "ResearchRecord",
      timestamps: false,
    },
  );

  return ResearchRecord;
};
