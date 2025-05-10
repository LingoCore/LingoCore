import { UserRepository } from "../repositories/user.js";
import { CourseRepository } from "../repositories/course.js";

export const courseListAll = async (req, res) => {
    const repo = new CourseRepository()
    const courses = await repo.listAll();
    try {
        return res.status(200).json({ courses });
    } catch (e) {
        return res.status(500).json({ message: e.toString() });
    }
}

export const courseEnroll = async (req, res) => {
    const { courseId } = req.body;
    const userId = req.user.id;

    const repo = new UserRepository();
    try {
        const user = await repo.findById(userId);
        if (!user) return res.status(404).json({ message: "User not found" });
        await repo.enrollInCourse(user.id, courseId);
        res.json({ message: "Successfully enrolled." });
    } catch (e) {
        res.status(500).json({ message: e.toString() });
    }
}

export const courseLeave = async (req, res) => {
  const { courseId } = req.body;
  const userId = req.user.id;

  const repo = new UserRepository();
  try {
    await repo.leaveCourse(userId, courseId);
    const user = await repo.findById(userId);
    res.status(200).json({ message: "Successfully left the course." });
  } catch (e) {
    res.status(500).json({ message: e.toString() });
  }
}