export class UserCourse {
    constructor({id, userId, courseId, currentLessonId}) {
        this.id = id;
        this.userId = userId;
        this.courseId = courseId;
        this.currentLessonId = currentLessonId;
    }
}