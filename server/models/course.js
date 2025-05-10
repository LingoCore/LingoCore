import { sequelize } from "../db.js";
import { DataTypes } from "sequelize";

export const CourseModel = sequelize.define("Course", {
  id: {
    primaryKey: true,
    type: DataTypes.UUID,
    defaultValue: DataTypes.UUIDV4
  },
  displayName: DataTypes.STRING,
  nativeLanguage: DataTypes.STRING,
  targetLanguage: DataTypes.STRING,
});
