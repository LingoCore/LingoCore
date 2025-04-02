import express from "express"
import bodyParser from "body-parser"
import cors from "cors"

const app = express();
const PORT = 3000;


// Middleware
app.use(cors());
app.use(bodyParser.json());

// Sunucuyu Başlat
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
