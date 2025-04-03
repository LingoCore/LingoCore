import express from "express"
import bodyParser from "body-parser"
import cors from "cors"

const app = express();
const PORT = 3000;


// Middleware
app.use(cors());
app.use(bodyParser.json());


/**
 * @typedef { Object } User
 * @property {string} userId
 * @property {string} username
 * @property {string} email
 * @property {[string]} courses
 */

// Fake Database (Örnek veriler)
/**
 * @type [User]
 */
let users = [
  { id: '0', username: 'deniztunc', email: 'deniz@example.com', courses: ["english"] },
  { id: '1', username: 'emrecamuz', email: 'emre@example.com', courses: ["english"] },
  { id: '2', username: 'egeyolsal', email: 'ege@example.com', courses: ["english"] }
];

// Temporary implementation without any auth
app.post("/api/auth/testlogin", (req, res) => {
  const { id } = req.body;
  const selectedUser = users.find(user => user.id === id);
  if (!selectedUser) {
    res.status(401).json({ message: "User id not found." }).send();
  }
  res.status(200).json({ message: "Login successfull", data: selectedUser }).send();
})

// Sunucuyu Başlat
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
