import { DataTypes } from "sequelize";
import { sequelize } from "../db.js";
import { UUIDV4 } from "sequelize/lib/data-types";

export const UserCourseModel = sequelize.define("userCourse", {
    id: {
        type: DataTypes.UUID,
        primaryKey: true,
        allowNull: false,
        defaultValue: UUIDV4,
    },
    userId: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    courseId: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    currentLesson: {
        type: DataTypes.STRING,
    },
    lastAccessedAt: {
        type: DataTypes.DATE,
        defaultValue: sequelize.Sequelize.NOW,
    },
});