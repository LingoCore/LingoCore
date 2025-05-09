import { Lesson } from "../domain/lesson.js";
import { LessonModel } from "../models/lesson.js";

export class LessonRepository {
    async findById(id) {
        const lesson = await LessonModel.findByPk(id);
        return lesson ? new Lesson(lesson.dataValues) : null;
    }
}