import { UserRepository } from "../repositories/user.js";
import { UserCourse } from "./userCourse.js";


export class User {
  /** @type {UserCourse[]} @const */
  userCourses;

  constructor({ id, username, email, userCourses, tokenVersion }) {
    this.id = id;
    this.username = username;
    this.email = email;
    this.userCourses = userCourses.map((c) => new UserCourse(c.dataValues));
    this.tokenVersion = tokenVersion;
  }

  enrollInCourse(courseId) {
    if (this.userCourses) {
      throw new Error("Already enrolled in this course");
    }
    this.courses.push(courseId);
  }

  leaveCourse(courseId) {
    if (!this.courses.includes(courseId)) {
      throw new Error("You are not enrolled in this course");
    }
    this.courses = this.courses.filter((c) => c !== courseId);
  }
}

