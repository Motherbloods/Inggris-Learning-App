const mongoose = require("mongoose");

const lessonSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  content: {
    type: String,
    required: true,
  },
  media: {
    type: [String],
  },
  exercises: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Exercise",
    },
  ],
  createdAt: {
    type: Date,
    default: Date.now,
  },
  level: Number,
});

const Lesson = mongoose.model("Lesson", lessonSchema);

module.exports = Lesson;

const lessons = [
  {
    title: "Introduction to Spanish",
    content:
      "Welcome to your first Spanish lesson! In this lesson, you'll learn basic greetings and how to introduce yourself.",
    exercises: ["66b03c3d2fd165e11e84a049", "66b03c3d2fd165e11e84a04a"], // Replace with actual ObjectId from Exercise collection
    level: 1,
  },
  {
    title: "Spanish Pronunciation",
    content:
      "This lesson focuses on pronunciation. You'll learn how to pronounce common Spanish vowels and consonants.",
    exercises: ["66b03c3d2fd165e11e84a04b", "66b03c3d2fd165e11e84a04c"], // Replace with actual ObjectId from Exercise collection
    level: 1,
  },
  {
    title: "Basic Spanish Phrases",
    content:
      "Learn essential phrases for everyday conversations, such as asking for directions and ordering food.",
    exercises: ["66b03c3d2fd165e11e84a04d"], // Replace with actual ObjectId from Exercise collection
    level: 2,
  },
  // {
  //   title: "Spanish Numbers",
  //   content:
  //     "This lesson will teach you how to count from 1 to 100 in Spanish.",
  //   exercises: [], // Replace with actual ObjectId from Exercise collection
  //   level: 2,
  // },
  // {
  //   title: "Spanish Verbs",
  //   content:
  //     "Learn about common Spanish verbs and their conjugations in the present tense.",
  //   exercises: [], // Replace with actual ObjectId from Exercise collection
  //   level: 3,
  // },
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
//     await Lesson.insertMany(lessons);
//     console.log("Data dummy berhasil dimasukkan ke database!");
//     mongoose.connection.close();
//   } catch (error) {
//     console.error("Error saat memasukkan data dummy:", error);
//   }
// };

// seedLessons();
