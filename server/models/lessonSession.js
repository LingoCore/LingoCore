import { DataTypes } from "sequelize";
import { sequelize } from "../db.js";

export const LessonSessionModel = sequelize.define("LessonSession", {
  id: {
    type: DataTypes.UUID,
    primaryKey: true,
    defaultValue: DataTypes.UUIDV4
  },
  userId: {
    type: DataTypes.UUID,
    references: {
      model: "Users",
      key: "id",
    },
    allowNull: false,
  },
  lessonId: {
    type: DataTypes.UUID,
    references: {
      model: "Lessons",
      key: "id",
    },
    allowNull: false,
  },
  questionCount: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  currentQuestionId: {
    type: DataTypes.UUID,
    references: {
      model: "Questions",
      key: "id",
    },
  },
});
