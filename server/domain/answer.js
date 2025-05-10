import { Question } from "./question.js";

export class Answer {
    constructor({ id, lessonSessionId, question, answer }) {
        this.id = id;
        this.lessonSessionId = lessonSessionId;
        this.question = new Question(question.dataValues);
        this.answer = answer;
    }
}