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

}

