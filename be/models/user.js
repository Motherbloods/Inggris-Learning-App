const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  username: String,
  email: String,
  password: String,
  progress: { type: Number, default: 0 },
  level: { type: Number, default: 1 },
  avatarUrl: {
    type: String,
    default:
      "https://tse1.mm.bing.net/th?id=OIP.avb9nDfw3kq7NOoP0grM4wHaEK&pid=Api&rs=1&c=1&qlt=95&w=165&h=92",
  },
});

const User = mongoose.model("User_learning", userSchema);

module.exports = User;
