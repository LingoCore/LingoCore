import { Answer } from "./answer.js";
import { Lesson } from "./lesson.js";
import { Question } from "./question.js";

export class LessonSession {

    constructor({ id, userId, questionCount, currentQuestion, answers, lesson }) {
        this.id = id;
        this.lesson = new Lesson(lesson);
        this.userId = userId;
        this.questionCount = questionCount;
        /** @type {Question} */
        this.currentQuestion = new Question(currentQuestion);
        /** @type {Answer[]} */
        this.answers = answers.map((a) => new Answer(a));
    }
}