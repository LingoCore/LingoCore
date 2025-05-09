import { sequelize } from "../db.js";
import { DataTypes } from "sequelize";

export const QuestionModel = sequelize.define("Question", {
  id: { type: DataTypes.STRING, primaryKey: true },
  lessonId: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  questionTitle: DataTypes.STRING,
  questionText: DataTypes.STRING,
  questionType: DataTypes.ENUM("text", "multipleChoice"),
  options: DataTypes.TEXT,
  answer: DataTypes.TEXT,
});

