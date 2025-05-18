import { Course } from "./course.js";

export class UserCourse {
    constructor({id, userId, courseId, currentLessonId, course}) {
        this.id = id;
        this.userId = userId;
        this.courseId = courseId;
        this.course = new Course(course.dataValues);
        this.currentLessonId = currentLessonId;
    }
}