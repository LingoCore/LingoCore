import { Sequelize } from "sequelize";
import { AnswerModel } from "../models/answer.js";
import { LessonModel } from "../models/lesson.js";
import { LessonSessionModel } from "../models/lessonSession.js";
import { QuestionModel } from "../models/question.js";
import { UserModel } from "../models/user.js";
import { LessonRepository } from "./lesson.js";
import { UserRepository } from "./user.js";
import { LessonSession } from "../domain/lessonSession.js";
import { Question } from "../domain/question.js";
import { Answer } from "../domain/answer.js";

export class LessonSessionRepository {
    async startSession(userId, lessonId) {
        const lesson = await new LessonRepository().findById(lessonId);
        if (!lesson) {
            throw new Error(`Lesson with id ${lessonId} not found`);
        }
        const user = await new UserRepository().findById(userId);
        if (!user) {
            throw new Error(`User with id ${userId} not found`);
        }
        if (user.userCourses.every(course => course.courseId !== lesson.courseId)) {
            throw new Error(`User with id ${userId} is not enrolled in course with id ${lesson.courseId}`);
        }

        const session = await LessonSessionModel.create({
            userId: userId,
            lessonId: lessonId,
            startTime: new Date(),
            questionCount: lesson.questionCount,
            currentQuestionId: (await this.getRandomQuestion(lessonId)).id
        });

        return session.id;
    }

    async findById(id) {
        const session = await LessonSessionModel.findByPk(id, {
            include: [
                { model: LessonModel, as: "lesson", include: QuestionModel },
                { model: AnswerModel, as: "answers", include: [{model: QuestionModel, as: "question"}], },
                { model: QuestionModel, as: "currentQuestion" },
            ],
        });
        return session ? new LessonSession(session.dataValues) : null
    }


    async getState(id) {
        const session = await this.findById(id);
        debugger;
        if (!session) {
            throw new Error(`Session with id ${id} not found`);
        }
        const answers = session.answers;
        debugger;
        const correctAnswers = answers.filter(answer => answer.question.answer === answer.answer);
        const wrongAnswers = answers.filter(answer => answer.question.answer !== answer.answer);
        const currentQuestion = session.currentQuestion;
        delete currentQuestion.answer;
        const progress = correctAnswers.length / session.questionCount - (wrongAnswers.length / session.questionCount * 0.2);
        return {
            progress,
            currentQuestion,
        }

    }

    async answerQuestion(sessionId, answer) {
        const session = await this.findById(sessionId);
        if (!session) {
            throw new Error(`Session with id ${sessionId} not found`);
        }
        const question = session.currentQuestion;
        if (!question) {
            throw new Error(`Session doesn't have an active question`);
        }
        const isCorrect = question.answer === answer;
        await AnswerModel.create({
            lessonSessionId: session.id,
            questionId: question.id,
            answer,
            // isCorrect eklenebilir belki
        });

        const nextQuestion = await this.getRandomQuestion(session.lesson.id);
        await LessonSessionModel.update(
            { currentQuestionId: nextQuestion.id },
            { where: { id: session.id }, fields: ["currentQuestionId"] }
        );
        return {
            isCorrect,
            correctAnswer: question.answer,
        }
    }

    async getRandomQuestion(lessonId) {
        return QuestionModel.findOne({
            where: { lessonId },
            order: Sequelize.literal('random()')
        });
    }

}