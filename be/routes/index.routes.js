const express = require("express");
const router = express.Router();
const { login, register } = require("../controllers/user.controller");
const {
  createExercise,
  getExerciseById,
  getExercises,
} = require("../controllers/exercise.controller");
const {
  createLesson,
  getLessonById,
  getLessons,
  updateLesson,
  deleteLesson,
  getMaterialById,
} = require("../controllers/lesson.controller");
const {
  updateProgress,
  getProgress,
} = require("../controllers/progress.controller");

//User Routes
router.post("/api/register", register);
router.post("/api/login", login);

//Lesson Routes
router.post("/api/lessons", createLesson);
router.get("/api/lessons", getLessons);
router.get("/api/lessons/:id", getLessonById);
router.put("/api/lessons/:id", updateLesson);
router.delete("/api/lessons/:id", deleteLesson);
router.get("/api/lessons/material/:id", getMaterialById);

//Exercise Routes
router.post("/api/exercises", createExercise);
router.get("/api/exercises", getExercises);
router.get("/api/exercises/:id", getExerciseById);

//Progress Routes
router.get("/api/progress/:userId", getProgress);
router.post("/api/users/:userId/lesson-progress", updateProgress);

module.exports = router;
