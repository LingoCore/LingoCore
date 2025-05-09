import { sequelize } from "../db.js";
import { DataTypes } from "sequelize";

export const LessonModel = sequelize.define("Lesson", {
  id: {
    primaryKey: true,
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
  },
  courseId: {
    type: DataTypes.UUID,
    allowNull: false,
    unique: "lessonPosition"
  },
  position: { type: DataTypes.FLOAT, allowNull: false, unique: "lessonPosition" },
  title: DataTypes.STRING,
  description: DataTypes.STRING,
  questionCount: DataTypes.INTEGER,
});
