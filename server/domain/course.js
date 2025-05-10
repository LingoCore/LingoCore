import { Lesson } from './lesson.js';

export class Course {
    constructor({id, displayName, nativeLanguage, targetLanguage, Lessons}) {
        this.id = id;
        this.displayName = displayName;
        this.nativeLanguage = nativeLanguage;
        this.targetLanguage = targetLanguage;
        this.lessons = Lessons.map((l) => new Lesson(l))
    }
}