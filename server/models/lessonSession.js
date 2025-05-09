import { DataTypes } from "sequelize";
import { sequelize } from "../db.js";

export const LessonSessionModel = sequelize.define("LessonSession", {
  id: { type: DataTypes.STRING, primaryKey: true },
  userId: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  startedAt: {
    type: DataTypes.DATE,
    defaultValue: sequelize.Sequelize.NOW,
  },
});
