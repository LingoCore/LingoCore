export class Lesson {
    constructor({id, courseId, position, title, description, questionCount}) {
        this.id = id;
        this.courseId = courseId;
        this.position = position;
        this.title = title;
        this.description = description;
        this.questionCount = questionCount;
    }

}