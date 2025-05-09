import { DataTypes } from "sequelize";
import { sequelize } from "../db.js";

export const AnswerModel = sequelize.define("Answer", {
    id: {
        type: DataTypes.STRING,
        primaryKey: true,
    },
    lessonSessionId: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    questionId: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    answer: {
        type: DataTypes.TEXT,
        allowNull: false,
    },
    createdAt: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW,
    },
});