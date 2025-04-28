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

/**
 * A course i.e. a language pair.
 */
const Course = sequelize.define("Course", {
  id: { type: DataTypes.INTEGER, primaryKey: true },
  displayName: DataTypes.STRING,
  nativeLanguage: DataTypes.STRING,
  targetLanguage: DataTypes.STRING,
});

User.hasMany(Course, { foreignKey: "userId" });

/**
 * A lesson belonging to a course.
 * Each lesson must have a position in the course.
 * The position is used to determine the order of the lessons.
 */
const Lesson = sequelize.define("Lesson", {
  id: { type: DataTypes.STRING, primaryKey: true },
  position: {type: DataTypes.INTEGER, allowNull: false, unique: true},
  title: DataTypes.STRING,
  description: DataTypes.STRING,
  questionCount: DataTypes.INTEGER,
});

Course.hasMany(Lesson, { foreignKey: "courseId" });

/**
 * A question belonging to a lesson.
 * 
 * There can be any number of questions in a lesson.
 * A predefined number of questions will be picked at random
 * to be shown to the user.
 */
const Question = sequelize.define("Question", {
  id: { type: DataTypes.STRING, primaryKey: true },
  questionTitle: DataTypes.STRING,
  questionText: DataTypes.STRING,
  questionType: DataTypes.ENUM("text", "multipleChoice"),
  options: DataTypes.TEXT,
  answer: DataTypes.TEXT,
});

Lesson.hasMany(Question, { foreignKey: "lessonId" });

export { sequelize, User, Course, Lesson, Question };
