import { UserRepository } from "../repositories/user.js";
import jwt from "jsonwebtoken";
import { tokenProps } from "../utils/auth.js";

/** @type {import("express").RequestHandler} */
export const authTestlogin = async (req, res) => {
  const { username } = req.body;
  const repo = new UserRepository();
  try {
    const user = await repo.findByUsername(username);
    if (!user) return res.status(401).json({ message: "User id not found." });

    const {accessToken, refreshToken} = await repo.generateTokens(user.id);
    res.status(200).json({ message: "Login successful", accessToken, refreshToken });
  } catch (e) {
    res.status(500).json({ message: e.toString() });
  }
}

/** @type {import("express").RequestHandler} */
export const authTokeninfo = async (req, res) => {
  const { token, type } = req.body;
  try {
    const decoded = jwt.verify(token, tokenProps[type].secret);
    res.json(decoded).send();
  } catch (e) {
    console.error(e)
    res.json({ error: e }).send();
  }
}