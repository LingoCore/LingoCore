import { CourseModel } from "./course.js";
import { QuestionModel } from "./question.js";
import { LessonModel } from "./lesson.js";
import { UserModel } from "./user.js";
import { UserCourseModel } from "./usercourse.js";
import { LessonSessionModel } from "./lessonSession.js";
import { ChatMessageModel } from "./chatMessage.js";
import { AnswerModel } from "./answer.js";

export function setupRelations() {
  UserModel.hasMany(UserCourseModel, { foreignKey: "userId" });
  UserCourseModel.belongsTo(UserModel, { foreignKey: "userId" });

  UserCourseModel.belongsTo(CourseModel, { foreignKey: "courseId", as: "course" });
  CourseModel.hasMany(LessonModel, { foreignKey: "courseId", as: "lessons" });
  LessonModel.belongsTo(CourseModel, { foreignKey: "courseId" });
  LessonModel.hasMany(QuestionModel, { foreignKey: "lessonId" });
  QuestionModel.belongsTo(LessonModel, { foreignKey: "lessonId" });

  CourseModel.hasMany(ChatMessageModel, { foreignKey: "courseId" });
  ChatMessageModel.belongsTo(CourseModel, { foreignKey: "courseId" });

  UserModel.hasMany(LessonSessionModel, { foreignKey: "userId" });
  LessonSessionModel.hasMany(AnswerModel, { foreignKey: "lessonSessionId", as: "answers" });
  AnswerModel.belongsTo(QuestionModel, { foreignKey: "questionId", as: "question" });
  LessonSessionModel.belongsTo(QuestionModel, { foreignKey: "currentQuestionId", as: "currentQuestion" });

  LessonSessionModel.belongsTo(LessonModel, { foreignKey: "lessonId", as: "lesson" });


  UserModel.hasMany(ChatMessageModel, { foreignKey: "userId" });
  ChatMessageModel.belongsTo(UserModel, { foreignKey: "userId" });

}
