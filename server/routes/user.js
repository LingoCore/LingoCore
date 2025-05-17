import { UserRepository } from "../repositories/user.js";

/** @type {import("express").RequestHandler} */
export const userInfo = async (req, res) => {
  const { username } = req.params;

  const repo = new UserRepository();
  try {
    const user = await repo.findByUsername(username);
    if (!user) return res.status(404).json({ message: "User not found" });
    if (req.user.id === user.id) {
      return res.json({ user });
    } else {
      delete user.tokenVersion;
      delete user.email;
      return res.json({ user });
    }
  } catch (e) {
    return res.status(500).json({ message: e.toString() });
  }
}
