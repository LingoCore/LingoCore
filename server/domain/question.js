export class Question {
    constructor({ id, lessonId, questionTitle, questionText, questionType, options, answer }) {
        this.id = id;
        this.lessonId = lessonId;
        this.questionTitle = questionTitle;
        this.questionText = questionText;
        this.questionType = questionType;
        this.options = options;
        this.answer = answer;
    }
}