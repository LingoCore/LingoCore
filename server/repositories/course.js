import { Course } from "../domain/course.js";
import { CourseModel } from "../models/course.js";
import { LessonModel } from "../models/lesson.js";

export class CourseRepository {
    async createCourse(name, description, targetLanguage, nativeLanguage) {
        return CourseModel.create({
            name: name,
            description: description,
            targetLanguage: targetLanguage,
            nativeLanguage: nativeLanguage
        })
    }

    async listAll() {
        const courses = await CourseModel.findAll({include: [LessonModel]});
        return courses.map((c) => new Course(c.dataValues));
    }
}