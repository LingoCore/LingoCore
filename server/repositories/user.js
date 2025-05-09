import { UserModel } from "../models/user.js";
import { User } from "../domain/user.js";
import { UserCourseModel } from "../models/usercourse.js";
import { CourseModel } from "../models/course.js";
import { LessonModel } from "../models/lesson.js";
import { generateToken } from "../utils/auth.js";

export class UserRepository {
  async findById(id) {
    const user = await UserModel.findByPk(id, {include: UserCourseModel});
    return user ? new User(user.dataValues) : null;
  }

  async findByUsername(username) {
    const user = await UserModel.findOne({where: {username: username}, include: UserCourseModel});
    return user ? new User(user.dataValues) : null;
  }

  async create(userData) {
    const user = await UserModel.create(userData);
    return new User(user);
  }

  async update(userId, updates) {
    const [affectedRows] = await UserModel.update(updates, {
      where: { id: userId }
    });
    return affectedRows > 0;
  }

  async generateTokens(userId) { 
    const user = await UserModel.findByPk(userId);
    if (!user) {
      throw new Error(`User with id ${userId} not found`);
    }
    user.tokenVersion++;
    await user.save();
    return {
      accessToken: generateToken(user, "access"),
      refreshToken: generateToken(user, "refresh")
    };
  }

  async enrollInCourse(userId, courseId) {
    if (await UserCourseModel.count({where: {userId: userId, courseId: courseId}}) !== 0) {
      throw new Error(`User #${userId} enrolled in course #${courseId}`);
    }
    LessonModel.findOne({where: {courseId: courseId}, order: [["position", "ASC"]]});
    return UserCourseModel.create({courseId: courseId, userId: userId})
  }

  async leaveCourse(userId, courseId) {
    const selected = await UserCourseModel.findOne({where: {userId: userId, courseId: courseId}})
    if (!selected) {
      throw new Error(`User #${userId} not enrolled in course #${courseId}`);
    }
    return UserCourseModel.destroy({where: {id: selected.id}});
  }
}
