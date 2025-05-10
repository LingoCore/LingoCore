import { DataTypes } from "sequelize";
import { sequelize } from "../db.js";

export const AnswerModel = sequelize.define("Answer", {
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
    },
    lessonSessionId: {
        type: DataTypes.UUID,
        references: {
            model: "LessonSessions",
            key: "id",
        },
        allowNull: false,
    },
    questionId: {
        type: DataTypes.UUID,
        references: {
            model: "Questions",
            key: "id",
        },
        allowNull: false,
    },
    answer: {
        type: DataTypes.TEXT,
        allowNull: false,
    },
});