import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import morgan from "morgan";
import cookieParser from "cookie-parser";
import requireDebugCookie from "../server/middleware/requireDebugCookie.js";
import authenticateToken from "../server/middleware/authenticateToken.js";
import cookie from "cookie";
import jwt from "jsonwebtoken";

///////// For chat
import { createServer } from "http";
import { Server } from "socket.io";
///////////

import path from "path";
import { fileURLToPath } from "url";
import {
  getAllProducts,
  getProduct,
  createProduct,
  updateProduct,
  deleteProduct,
  signin,
  signout,
  createUser,
  getMessagesFromClient,
} from "../server/controllers/dinProdukter.js";
// Get current file's directory
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config({ path: "./config/config.env" });

const app = express();

// For chat merging two servers
const httpServer = createServer(app);
const io = new Server(httpServer, {
  cors: {
    origin: "http://localhost:5173",
    credentials: true,
  },
});
io.on("connection", (socket) => {
  const cookies = cookie.parse(socket.handshake.headers.cookie || "");
  const token = cookies.token;
  console.log("RAW COOKIE HEADER:", socket.handshake.headers.cookie);

  if (!token) {
    console.log("As there is no token so i have to disconnect");
    return socket.disconnect();
  }
  console.log(`A new user connected: ${socket.id}`);
  let user;
  try {
    console.log("try block");

    user = jwt.verify(token, process.env.JWT_SECRET);
  } catch (error) {
    console.log("Invalid or missing cookie token");
    console.log(error.message);

    socket.disconnect();
  }

  socket.user = user;

  console.log(`User connected: ${user.user_name}`);
  // it is not working
  socket.emit(
    "messageFromServer",
    `${socket.user.user_name}: What are you saying`
  );
  // message received from client
  socket.on("messageFromClient", (message) => {
    console.log("message received from client: ", message); // broadcasting this message to all connected users except the user who is sending this message
    // this message will be saved in MySql user table
    // user_message
    socket.broadcast.emit("messageFromServer", message);
  });
  // acknowledgement
  // send an event with acknowledgement
  socket.emit(
    "deliveredMessage",
    "Hello! Welcome to the server",
    (response) => {
      console.log("The client has received the message", response);
    }
  );

  socket.on("disconnect", () => {
    console.log(`The user disconnected who had id: ${socket.id}`);
  });
});

if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
}

app.use(
  cors({
    origin: "http://localhost:5173",
    credentials: true,
  })
);

app.use(cookieParser());
// Body Parser, already available in express
app.use(express.json());

const port = process.env.PORT || 3000;
const router = express.Router();
router.route("/signin").post(authenticateToken, signin);
router.route("/signout").post(signout);
router.route("/signup").post(createUser);

app.use("/api/dinprodukter", authenticateToken);

router.route("/products").get(requireDebugCookie, getAllProducts);
router
  .route("/")
  .get(getAllProducts) // reading all products from MySql product table
  .post(createProduct);
// router.route("/chat").get(getMessagesFromClient);
router.route("/createproduct").post(createProduct); // creating a new product by loggedin user

router
  .route("/:prodId")
  .get(getProduct)
  .put(updateProduct)
  .delete(deleteProduct);

app.use("/api/dinprodukter", router);
// app.set("view engine", ".hbs");
// app.set("views", "../server/views");
httpServer.listen(process.env.PORT, () =>
  console.log(
    `Web Server is running in ${process.env.NODE_ENV} mode on port ${port}`
  )
);
