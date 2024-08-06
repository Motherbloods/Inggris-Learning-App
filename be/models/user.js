const mongoose = require("mongoose");

const materialSchema = new mongoose.Schema(
  {
    id: { type: mongoose.Schema.Types.ObjectId, ref: "Material_Lesson" },
    completed: { type: Boolean, default: false },
  },
  { _id: false }
);

const lessonSchema = new mongoose.Schema({
  lessonId: { type: mongoose.Schema.Types.ObjectId, ref: "Lesson" },
  materialIds: [materialSchema],
  progress: { type: Number, default: 0 },
});

const userSchema = new mongoose.Schema({
  username: String,
  email: String,
  password: String,
  level: { type: Number, default: 1 },
  lessons: [lessonSchema],
  avatarUrl: {
    type: String,
    default:
      "https://tse1.mm.bing.net/th?id=OIP.avb9nDfw3kq7NOoP0grM4wHaEK&pid=Api&rs=1&c=1&qlt=95&w=165&h=92",
  },
  progress: { type: Number, default: 0 },
  xp: { type: Number, default: 0 },
});

const User = mongoose.model("User_learning", userSchema);

module.exports = User;
