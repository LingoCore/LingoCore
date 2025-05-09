import { sequelize } from "../db.js";
import { DataTypes, UUIDV4 } from "sequelize";

export const UserModel = sequelize.define("User", {
  id: {
    type: DataTypes.UUID,
    primaryKey: true,
    defaultValue: UUIDV4
  },
  username: DataTypes.STRING,
  email: DataTypes.STRING,
  tokenVersion: DataTypes.INTEGER,
});
