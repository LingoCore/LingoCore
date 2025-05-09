import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import jwt from "jsonwebtoken";
import { authenticate } from "./utils/authMiddleware.js";
import { ACCESS_TOKEN_SECRET, generateToken, tokenProps } from "./utils/auth.js";
import { sequelize } from "./db.js";
import { setupRelations } from "./models/setup.js";
import { UserModel } from "./models/user.js";
import { UserRepository } from "./repositories/user.js";
import { CourseModel } from "./models/course.js";
import { UserCourseModel } from "./models/usercourse.js";
import { LessonModel } from "./models/lesson.js";
import { CourseRepository } from "./repositories/course.js";

const app = express();
const PORT = 3000;

process.loadEnvFile();

// Middleware
app.use(cors());
app.use(bodyParser.json());

app.post("/api/auth/testlogin", async (req, res) => {
  const { username } = req.body;
  const repo = new UserRepository();
  try {
    const user = await repo.findByUsername(username);
    if (!user) return res.status(401).json({ message: "User id not found." });

    const {accessToken, refreshToken} = await repo.generateTokens(user.id);
    res.status(200).json({ message: "Login successful", accessToken, refreshToken });
  } catch (e) {
    res.status(500).json({ message: e.toString() });
  }
});

app.post("/api/auth/tokeninfo", (req, res) => {
  const { token, type } = req.body;
  try {
    const decoded = jwt.verify(token, tokenProps[type].secret);
    res.json(decoded).send();
  } catch (e) {
    console.error(e)
    res.json({ error: e }).send();
  }
})

app.get("/api/user/:username", authenticate, async (req, res) => {
  const { username } = req.params;

  const repo = new UserRepository();
  try {
    const user = await repo.findByUsername(username);
    if (!user) return res.status(404).json({ message: "User not found" });
    if (req.user.id === user.id) {
      return res.json({ user: user });
    } else {
      return res.json({
        user: { id: user.id, username: user.username, courses: user.userCourses },
      });
    }
  } catch (e) {
    return res.status(500).json({ message: e.toString() });
  }
});

app.get("/api/course/list/all", authenticate, async (req, res) => {
  const repo = new CourseRepository()
  const courses = await repo.listAll();
  try {
    return res.status(200).json({ courses });
  } catch (e) {
    return res.status(500).json({ message: e.toString() });
  }
});

app.post("/api/course/enroll", authenticate, async (req, res) => {
  const { courseId } = req.body;
  const userId = req.user.id;

  const repo = new UserRepository();
  try {
    const user = await repo.findById(userId);
    if (!user) return res.status(404).json({ message: "User not found" });
    await repo.enrollInCourse(user.id, courseId);
    res.json({ message: "Successfully enrolled." });
  } catch (e) {
    res.status(500).json({ message: e.toString() });
  }
});

app.post("/api/course/leave", authenticate, async (req, res) => {
  const { courseId } = req.body;
  const userId = req.user.id;

  const repo = new UserRepository();
  try {
    await repo.leaveCourse(userId, courseId);
    const user = await repo.findById(userId);
    res.status(200).json({ message: "Successfully left the course." });
  } catch (e) {
    res.status(500).json({ message: e.toString() });
  }
});

// defer server start until DB is ready
setupRelations();
sequelize
  .sync()
  .then(async () => {

    if ((await UserModel.count()) === 0) {
      await UserModel.bulkCreate([
        { username: "deniztunc", email: "deniz@example.com", tokenVersion: 0 },
        { username: "emrecamuz", email: "emre@example.com", tokenVersion: 0 },
        { username: "egeyolsal", email: "ege@example.com", tokenVersion: 0 },
      ]);
    }
    if ((await CourseModel.count()) === 0) {
      await CourseModel.bulkCreate([
        { displayName: "İngilizce", targetLanguage: "en-US", nativeLanguage: "tr-TR" },
        { displayName: "Rusça", targetLanguage: "ru-RU", nativeLanguage: "tr-TR" },
      ]);
    }

    if ((await LessonModel.count()) === 0) {
      const enCourse = await CourseModel.findOne({ where: { displayName: "İngilizce" } });
      await LessonModel.bulkCreate([
        { title: "Lesson 1", courseId: enCourse.id, position: 1, questionCount: 10, description: "Lesson 1 description" },
        { title: "Lesson 2", courseId: enCourse.id, position: 2, questionCount: 10, description: "Lesson 2 description" },
      ]);
    }

    app.listen(PORT, () => {
      console.log(`Server is running on http://localhost:${PORT}`);
    });
  })
  .catch((e) => console.error("DB sync error", e));
