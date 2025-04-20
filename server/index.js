import express from "express"
import bodyParser from "body-parser"
import cors from "cors"
import jwt from "jsonwebtoken"

import { } from "./utils/jsdoc.js"

import { ACCESS_TOKEN_SECRET, generateToken, tokenProps } from "./utils/auth.js"

const app = express();
const PORT = 3000;

process.loadEnvFile();

// Middleware
app.use(cors());
app.use(bodyParser.json());



/**
 * Fake Database (Örnek veriler)
 * @type [User]
 */
let users = [
  {
    id: '0',
    username: 'deniztunc',
    email: 'deniz@example.com',
    courses: ["english"],
    tokenVersion: 0,
  },
  {
    id: '1',
    username: 'emrecamuz',
    email: 'emre@example.com',
    courses: ["english"],
    tokenVersion: 0,
  },
  {
    id: '2',
    username: 'egeyolsal',
    email: 'ege@example.com',
    courses: ["english"],
    tokenVersion: 0
  }
];

// Temporary implementation without any auth
app.post("/api/auth/testlogin", (req, res) => {
  const { id } = req.body;
  const selectedUser = users.find(user => user.id === id);
  if (selectedUser == null) {
    res.status(401).json({ message: "User id not found." }).send();
    return;
  }
  selectedUser.tokenVersion++;
  const accessToken = generateToken(selectedUser, "access");
  const refreshToken = generateToken(selectedUser, "access");

  res.status(200).json({
    message: "Login successfull",
    accessToken,
    refreshToken
  }).send();
})

app.post("/api/tokeninfo", (req, res) => {
  const { token, type } = req.body;
  try {
    const decoded = jwt.verify(token, tokenProps[type].secret);
    res.json(decoded).send();
  } catch (e) {
    console.error(e)
    res.json({ error: e }).send();
  }
})

app.get("/api/user/:userId", (req, res) => {
  const { userId } = req.params;
  const user = users.find((u) => {
    return u.id == userId;
  });
  if (user == null) {
    res.status(404).json({ message: "User not found" }).send()
    return;
  }

  let token = req.headers.authorization;
  if (token != null && token.startsWith("Bearer ")) {
    token = token.slice("Bearer ".length);
    try {
      var decoded = jwt.verify(token, ACCESS_TOKEN_SECRET);
    } catch (e) {
      res.status(401).json({ message: e }).send()
      return;
    }
    const tokenOwner = users.find(u => u.id = decoded.id);
    if (!tokenOwner || decoded.version !== tokenOwner.tokenVersion) {
      res.status(401).json({ message: "Token Version Expired" });
      return;
    }
  }

  if (decoded && decoded.id === userId) {
    res.json({
      user
    }).send()
  }
  else {
    res.json({
      user: {
        id: userId,
        username: user.username,
        courses: user.courses
      }
    }).send()
  }
})

// Sunucuyu Başlat
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
