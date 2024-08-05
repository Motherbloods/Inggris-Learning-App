const mongoose = require("mongoose");

const exerciseSchema = new mongoose.Schema({
  lessonId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Lesson",
    required: true,
  },
  type: {
    type: String,
    enum: ["multiple_choice", "fill_in_the_blank", "true_false"],
    required: true,
  },
  question: {
    type: String,
    required: true,
  },
  options: {
    type: [String],
    required: function () {
      return this.type === "multiple_choice";
    },
  },
  correctAnswer: {
    type: String,
    required: true,
  },
  explanation: {
    type: String,
  },
  level: {
    type: Number,
    default: 1,
  },
});

const Exercise = mongoose.model("Exercise", exerciseSchema);

module.exports = Exercise;

const exercises = [
  {
    lessonId: "66b03b7b4d279799de99b980", // Ganti dengan ObjectId dari koleksi Lesson
    type: "multiple_choice",
    question: "What is the capital of Spain?",
    options: ["Madrid", "Barcelona", "Valencia", "Seville"],
    correctAnswer: "Madrid",
    explanation: "Madrid is the capital and largest city of Spain.",
    level: 1,
  },
  {
    lessonId: "66b03b7b4d279799de99b980", // Ganti dengan ObjectId dari koleksi Lesson
    type: "true_false",
    question: "Spain is in Europe.",
    correctAnswer: "true",
    explanation: "Spain is a country in southwestern Europe.",
    level: 1,
  },
  {
    lessonId: "66b03b7b4d279799de99b981", // Ganti dengan ObjectId dari koleksi Lesson
    type: "fill_in_the_blank",
    question: "The official language of Spain is ______.",
    correctAnswer: "Spanish",
    explanation: "Spanish is the official language of Spain.",
    level: 2,
  },
  {
    lessonId: "66b03b7b4d279799de99b981", // Ganti dengan ObjectId dari koleksi Lesson
    type: "multiple_choice",
    question: "Which of the following is a famous Spanish dish?",
    options: ["Sushi", "Tacos", "Paella", "Pasta"],
    correctAnswer: "Paella",
    explanation: "Paella is a traditional Spanish dish from Valencia.",
    level: 2,
  },
  {
    lessonId: "66b03b7b4d279799de99b982", // Ganti dengan ObjectId dari koleksi Lesson
    type: "multiple_choice",
    question: "What is the main ingredient in Gazpacho?",
    options: ["Tomatoes", "Potatoes", "Chicken", "Beef"],
    correctAnswer: "Tomatoes",
    explanation:
      "Gazpacho is a cold soup made from tomatoes and other vegetables.",
    level: 3,
  },
];

// mongoose.connect(
//   "mongodb+srv://motherbloodss:XKFofTN9qGntgqbo@cluster0.ejyrmvc.mongodb.net/?retryWrites=true&w=majority",
//   {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
//   }
// );

// const seedExercises = async () => {
//   try {
//     await Exercise.deleteMany({});
//     await Exercise.insertMany(exercises);
//     console.log("Data dummy berhasil dimasukkan ke database!");
//     mongoose.connection.close();
//   } catch (error) {
//     console.error("Error saat memasukkan data dummy:", error);
//   }
// };

// seedExercises();
