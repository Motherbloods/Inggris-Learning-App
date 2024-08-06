const mongoose = require("mongoose");

const lessonSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  createdAt: { type: Date, default: Date.now },
  level: Number,
  material: [{ type: mongoose.Schema.Types.ObjectId, ref: "Lesson_Material" }],
  progress: { type: Number, default: 0 },
});

const Lesson = mongoose.model("Lesson", lessonSchema);

module.exports = Lesson;

const lessonDumy = [
  {
    title: "Inggris Beginner",
    level: 1,
  },
  {
    title: "Inggris Medium",
    level: 2,
  },
  {
    title: "Inggris Hard",
    level: 2,
  },
];

// mongoose.connect(
//   "mongodb+srv://motherbloodss:XKFofTN9qGntgqbo@cluster0.ejyrmvc.mongodb.net/?retryWrites=true&w=majority",
//   {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
//   }
// );

// const seedLessons = async () => {
//   try {
//     await Lesson.deleteMany({});
//     await Lesson.insertMany(lessonDumy);
//     console.log("Data dummy berhasil dimasukkan ke database!");
//     mongoose.connection.close();
//   } catch (error) {
//     console.error("Error saat memasukkan data dummy:", error);
//   }
// };

// seedLessons();
