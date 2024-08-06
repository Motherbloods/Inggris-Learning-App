const Lesson = require("../models/lesson");
const Exercise = require("../models/exercise");
const Progress = require("../models/progress");
const User = require("../models/user");

const register = async (req, res) => {
  try {
    const { username, email, password } = req.body;
    if (!username || !email || !password) {
      return res.status(400);
    }
    const newUser = new User({ username, email, password });
    await newUser.save();
    res.status(200).send(newUser);
  } catch (err) {
    console.log(err);
  }
};
const login = async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400);
    }
    const user = await User.findOne({ email, password });
    if (!user) {
      return res.status(404).send("User not found");
    }
    res.status(200).send(user);
  } catch (err) {
    console.log(err);
  }
};

const createLesson = async (req, res) => {
  try {
    const { title, content, media } = req.body;
    const newLesson = new Lesson({ title, content, media });
    await newLesson.save();
    res.status(201).json(newLesson);
  } catch (err) {
    console.error(err);
  }
};
const getLessons = async (req, res) => {
  try {
    const lessons = await Lesson.find();
    res.status(200).json(lessons);
  } catch (err) {
    console.error(err);
  }
};
const getLessonById = async (req, res) => {
  const lesson = await Lesson.findById(req.params.id).populate("exercises");
  if (!lesson) return res.status(404).json({ message: "Lesson not found" });
  res.status(200).json(lesson);
  try {
  } catch (err) {
    console.error(err);
  }
};
const updateLesson = async (req, res) => {
  try {
    const updatedLesson = await Lesson.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    if (!updatedLesson)
      return res.status(404).json({ message: "Lesson not found" });
    res.status(200).json(updatedLesson);
  } catch (err) {
    console.error(err);
  }
};
const deleteLesson = async (req, res) => {
  try {
    const deletedLesson = await Lesson.findByIdAndDelete(req.params.id);
    if (!deletedLesson)
      return res.status(404).json({ message: "Lesson not found" });
    res.status(200).json({ message: "Lesson deleted successfully" });
  } catch (err) {
    console.error(err);
  }
};

const lessonLevel = async (req, res) => {
  try {
    const { level } = req.query;
    const exercises = await Exercise.find({ level });
    res.send(exercises);
  } catch (err) {
    console.error(err);
  }
};

const lessonProgress = async (req, res) => {
  try {
    const { userId, lessonId, exerciseId, score } = req.body;
    let progress = await Progress.findOne({ userId });
    if (!progress) {
      progress = new Progress({ userId });
    }
    if (lessonId) progress.lessonsCompleted.push(lessonId);
    if (exerciseId) progress.exercisesCompleted.push(exerciseId);
    progress.score += score;
    await progress.save();
    res.send(progress);
  } catch (error) {
    res.status(500).send(error);
  }
};

const createExercise = async (req, res) => {
  try {
    const { lessonId, type, question, options, correctAnswer, explanation } =
      req.body;
    const newExercise = new Exercise({
      lessonId,
      type,
      question,
      options,
      correctAnswer,
      explanation,
    });
    await newExercise.save();
    res.status(201).json(newExercise);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

const getExercises = async (req, res) => {
  try {
    const exercises = await Exercise.find();
    res.status(200).json(exercises);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

const getExerciseById = async (req, res) => {
  try {
    const exercise = await Exercise.findById(req.params.id);
    if (!exercise)
      return res.status(404).json({ message: "Exercise not found" });
    res.status(200).json(exercise);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

const updateExercise = async (req, res) => {
  try {
    const updatedExercise = await Exercise.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true }
    );
    if (!updatedExercise)
      return res.status(404).json({ message: "Exercise not found" });
    res.status(200).json(updatedExercise);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

const deleteExercise = async (req, res) => {
  try {
    const deletedExercise = await Exercise.findByIdAndDelete(req.params.id);
    if (!deletedExercise)
      return res.status(404).json({ message: "Exercise not found" });
    res.status(200).json({ message: "Exercise deleted successfully" });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
