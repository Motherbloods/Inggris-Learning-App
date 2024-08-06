const Lesson = require("../models/lesson");
const Exercise = require("../models/exercise");
const Progress = require("../models/progress");
const Material_Lesson = require("../models/materialLesson");

const createLesson = async (req, res) => {
  try {
    const { title, content, level, media } = req.body;
    const newLesson = new Lesson({ title, content, level, media });
    await newLesson.save();
    res.status(201).json(newLesson);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
};

const getLessons = async (req, res) => {
  try {
    const lessons = await Lesson.find();
    res.status(200).json(lessons);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
};

const getLessonById = async (req, res) => {
  try {
    const lesson = await Lesson.findById(req.params.id).populate("exercises");
    if (!lesson) return res.status(404).json({ message: "Lesson not found" });
    res.status(200).json(lesson);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
};

const updateLesson = async (req, res) => {
  try {
    const updatedLesson = await Lesson.findByIdAndUpdate(
      req.params.id,
      req.body,
      { new: true, runValidators: true }
    );
    if (!updatedLesson)
      return res.status(404).json({ message: "Lesson not found" });
    res.status(200).json(updatedLesson);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
};

const getMaterialById = async (req, res) => {
  try {
    const material = await Material_Lesson.find({
      lessonId: req.params.id,
    });
    if (!material)
      return res.status(404).json({ message: "Lesson material not found" });
    res.json(material);
  } catch (err) {
    res.status(500).json({ message: err.message });
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
    res.status(500).json({ message: "Server error" });
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

module.exports = {
  createLesson,
  getLessons,
  deleteLesson,
  updateLesson,
  getLessonById,
  getMaterialById,
};
