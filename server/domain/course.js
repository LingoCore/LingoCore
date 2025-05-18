import { Lesson } from './lesson.js';

export class Course {
    constructor({id, displayName, nativeLanguage, targetLanguage, lessons}) {
        this.id = id;
        this.displayName = displayName;
        this.nativeLanguage = nativeLanguage;
        this.targetLanguage = targetLanguage;
        this.lessons = [];
        if (lessons) {
            this.lessons = lessons.map((l) => new Lesson(l.dataValues))
        }
    }
}