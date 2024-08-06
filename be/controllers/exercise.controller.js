const Exercise = require("../models/exercise");
const Lesson = require("../models/materialLesson");

const createExercise = async (req, res) => {
  try {
    const { lessonId, type, question, options, correctAnswer, explanation } =
      req.body;
    const newExercise = new Exercise({
      lesson: lessonId,
      type,
      question,
      options,
      correctAnswer,
      explanation,
    });
    await newExercise.save();

    // Add exercise to the lesson
    await Lesson.findByIdAndUpdate(lessonId, {
      $push: { exercises: newExercise._id },
    });

    res.status(201).json(newExercise);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
};

const getExercises = async (req, res) => {
  try {
    const { materialId } = req.query;

    const exercises = await Exercise.find({ materialId });
    res.status(200).json(exercises);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
};

const getExerciseById = async (req, res) => {
  try {
    const exercise = await Exercise.findById(req.params.id);
    if (!exercise)
      return res.status(404).json({ message: "Exercise not found" });
    res.status(200).json(exercise);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = {
  createExercise,
  getExercises,
  getExerciseById,
};
