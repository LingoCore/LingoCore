import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import { authenticate } from "./utils/authMiddleware.js";
import { sequelize } from "./db.js";
import { setupRelations } from "./models/setup.js";
import { UserModel } from "./models/user.js";
import { CourseModel } from "./models/course.js";
import { LessonModel } from "./models/lesson.js";
import { courseEnroll, courseLeave, courseListAll } from "./routes/course.js";
import { userInfo } from "./routes/user.js";
import { authTestlogin, authTokeninfo } from "./routes/auth.js";
import { sessionStart, sessionGet, sessionPost } from "./routes/session.js";
import { QuestionModel } from "./models/question.js";

export const app = express();
const PORT = 3000;

process.loadEnvFile();

// Middleware
app.use(cors());
app.use(bodyParser.json());

/* api/auth */

app.post("/api/auth/testlogin", authTestlogin);

app.post("/api/auth/tokeninfo", authTokeninfo)

/* api/user */

app.get("/api/user/:username", authenticate, userInfo);

/* api/course  */

app.get("/api/course/list/all", authenticate, courseListAll);

app.post("/api/course/enroll", authenticate, courseEnroll);

app.post("/api/course/leave", authenticate, courseLeave);

/* api/session */
app.post("/api/session/start", authenticate, sessionStart);

app.get("/api/session/:sessionId", authenticate, sessionGet);

app.post("/api/session/:sessionId", authenticate, sessionPost);

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
      const ruCourse = await CourseModel.findOne({ where: { displayName: "Rusça" } });
      await LessonModel.bulkCreate([
        { title: "Урок 1", courseId: ruCourse.id, position: 1, questionCount: 10, description: "Описание первого урока" },
        { title: "Урок 2", courseId: ruCourse.id, position: 2, questionCount: 10, description: "Описание второго урока" },
      ]);
    }

    if ((await QuestionModel.count()) === 0) {
      const lesson1 = await LessonModel.findOne({ where: { title: "Lesson 1" } });
      const lesson2 = await LessonModel.findOne({ where: { title: "Lesson 2" } });
      const lesson3 = await LessonModel.findOne({ where: { title: "Урок 1" } });
      const lesson4 = await LessonModel.findOne({ where: { title: "Урок 2" } });
      await QuestionModel.bulkCreate([
        {
          lessonId: lesson1.id,
          questionTitle: "What is your name?",
          questionText: "",
          questionType: "multipleChoice",
          options: JSON.stringify(["Adın ne?", "Adın kim?", "Adın nasıl?", "Evet."]),
          answer: "Adın ne?"
        },
        {
          lessonId: lesson1.id,
          questionTitle: "What is your age?",
          questionText: "",
          questionType: "multipleChoice",
          options: JSON.stringify(["Yaşın kaç?", "-", "-", "-"]),
          answer: "Yaşın kaç?"
        },
        {
          lessonId: lesson2.id,
          questionTitle: "Blue",
          questionText: "",
          questionType: "multipleChoice",
          options: JSON.stringify(["Mavi", "Kırmızı", "Yeşil", "Sarı"]),
          answer: "Mavi"
        },
        {
          lessonId: lesson3.id,
          questionTitle: "Как тебя зовут?",
          questionText: "",
          questionType: "multipleChoice",
          options: JSON.stringify(["Как тебя зовут?", "-", "-", "-"]),
          answer: "Как тебя зовут?"
        },
        {
          lessonId: lesson3.id,
          questionTitle: "Сколько тебе лет?",
          questionText: "",
          questionType: "multipleChoice",
          options: JSON.stringify(["Сколько тебе лет?", "-", "-", "-"]),
          answer: "Сколько тебе лет?"
        },
        {
          lessonId: lesson4.id,
          questionTitle: "Синий",
          questionText: "",
          questionType: "multipleChoice",
          options: JSON.stringify(["Синий", "Красный", "Зеленый", "Желтый"]),
          answer: "Синий"
        },
      ]);
    }

    app.listen(PORT, () => {
      console.log(`Server is running on http://localhost:${PORT}`);
    });
  })
  .catch((e) => console.error("DB sync error", e));
