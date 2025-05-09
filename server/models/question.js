import { sequelize } from "../db.js";
import { DataTypes } from "sequelize";

export const QuestionModel = sequelize.define("Question", {
  id: {
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
    allowNull: false,
    primaryKey: true
  },
  lessonId: {
    type: DataTypes.UUID,
    references: {
      model: "Lessons",
      key: "id",
    },
    allowNull: false,
  },
  questionTitle: DataTypes.STRING,
  questionText: DataTypes.STRING,
  questionType: DataTypes.ENUM("text", "multipleChoice"),
  options: DataTypes.TEXT,
  answer: DataTypes.TEXT,
});

