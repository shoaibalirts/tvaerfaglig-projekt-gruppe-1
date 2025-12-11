import mysql from "mysql";
import dotenv from "dotenv";
dotenv.config({ path: "../server/config/config.env" });

var connection = mysql.createConnection({
  host: process.env.HOST,
  user: process.env.USER,
  password: process.env.PASSWORD,
  database: process.env.DATABASE,
});

export default connection;

// import mysql from "mysql";

// // Brug environment variables fra Render
// const connection = mysql.createConnection({
//   host: process.env.DB_HOST,     // mysql87.unoeuro.com
//   user: process.env.DB_USER,     // sofieroshni_dk
//   password: process.env.DB_PASS, // dit password
//   database: process.env.DB_NAME, // sofieroshni_dk_db
// });

// connection.connect((err) => {
//   if (err) {
//     console.error("DB connection failed:", err);
//     return;
//   }
//   console.log("Connected to MySQL database!");
// });

// export default connection;

