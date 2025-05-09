import { sequelize } from "../db.js";
import { DataTypes } from "sequelize";

export const LessonModel = sequelize.define("Lesson", {
  id: {
    primaryKey: true,
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4,
  },
  position: { type: DataTypes.FLOAT, allowNull: false, unique: true, },
  title: DataTypes.STRING,
  description: DataTypes.STRING,
  questionCount: DataTypes.INTEGER,
});
