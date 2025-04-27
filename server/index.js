import express from "express";
import bodyParser from "body-parser";
import cors from "cors";
import jwt from "jsonwebtoken";
import { authenticate } from "./utils/authMiddleware.js";
import { ACCESS_TOKEN_SECRET, generateToken, tokenProps } from "./utils/auth.js";
import { sequelize, User } from "./db.js";

const app = express();
const PORT = 3000;

process.loadEnvFile();

// Middleware
app.use(cors());
app.use(bodyParser.json());

app.post("/api/auth/testlogin", async (req, res) => {
  const { id } = req.body;
  try {
    const user = await User.findByPk(id);
    if (!user) return res.status(401).json({ message: "User id not found." });

    user.tokenVersion++;
    await user.save();
    const accessToken = generateToken(user, "access");
    const refreshToken = generateToken(user, "refresh");
    res.status(200).json({ message: "Login successful", accessToken, refreshToken });
  } catch {
    res.status(500).json({ message: "DB error" });
  }
});

app.post("/api/auth/tokeninfo", (req, res) => {
  const { token, type } = req.body;
  try {
    const decoded = jwt.verify(token, tokenProps[type].secret);
    res.json(decoded).send();
  } catch (e) {
    console.error(e)
    res.json({ error: e }).send();
  }
})

app.get("/api/user/:userId", authenticate, async (req, res) => {
  const { userId } = req.params;
  try {
    const user = await User.findByPk(userId);
    if (!user) return res.status(404).json({ message: "User not found" });

    const data = user.get({ plain: true });
    data.courses = JSON.parse(data.courses);
    if (req.user.id === userId) {
      return res.json({ user: data });
    } else {
      return res.json({
        user: { id: data.id, username: data.username, courses: data.courses },
      });
    }
  } catch {
    return res.status(500).json({ message: "DB error" });
  }
});

app.post("/api/user/:userId", authenticate, async (req, res) => {
  const { userId } = req.params;
  const { username, email } = req.body;

  // only allow owners to update their profile
  if (req.user.id !== userId) {
    return res.status(403).json({ message: "Forbidden: cannot update other user" });
  }

  try {
    const user = await User.findByPk(userId);
    if (!user) return res.status(404).json({ message: "User not found" });

    // update fields
    if (username) user.username = username;
    if (email) user.email = email;
    await user.save();

    const updated = user.get({ plain: true });
    updated.courses = JSON.parse(updated.courses);
    res.json({ user: updated });
  } catch {
    res.status(500).json({ message: "DB error" });
  }
});

// defer server start until DB is ready
sequelize
  .sync()
  .then(async () => {
    // seed if empty
    if ((await User.count()) === 0) {
      await User.bulkCreate([
        { id: "0", username: "deniztunc", email: "deniz@example.com", courses: JSON.stringify(["english"]), tokenVersion: 0 },
        { id: "1", username: "emrecamuz", email: "emre@example.com", courses: JSON.stringify(["english"]), tokenVersion: 0 },
        { id: "2", username: "egeyolsal", email: "ege@example.com", courses: JSON.stringify(["english"]), tokenVersion: 0 },
      ]);
    }

    app.listen(PORT, () => {
      console.log(`Server is running on http://localhost:${PORT}`);
    });
  })
  .catch((e) => console.error("DB sync error", e));
