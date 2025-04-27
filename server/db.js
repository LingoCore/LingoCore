import { Sequelize, DataTypes } from "sequelize";

const sequelize = new Sequelize({
  dialect: "sqlite",
  storage: "./database.sqlite",
  logging: false,
});

const User = sequelize.define("User", {
  id: { type: DataTypes.STRING, primaryKey: true },
  username: DataTypes.STRING,
  email: DataTypes.STRING,
  courses: DataTypes.TEXT,
  tokenVersion: DataTypes.INTEGER,
});

export { sequelize, User };
