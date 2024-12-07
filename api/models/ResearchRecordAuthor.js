module.exports = (sequelize, DataTypes) => {
  const ResearchRecordAuthor = sequelize.define(
    "ResearchRecordAuthor",
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      research_record_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "ResearchRecord",
          key: "id",
        },
      },
      author_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
        references: {
          model: "Author",
          key: "id",
        },
      },
    },
    {
      tableName: "ResearchRecordAuthor",
      timestamps: false,
    },
  );

  return ResearchRecordAuthor;
};
