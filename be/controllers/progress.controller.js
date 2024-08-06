const Progress = require("../models/progress");
const User = require("../models/user");
const Exercise = require("../models/exercise");
const mongoose = require("mongoose");

const BASE_XP = 10;
const DIFFICULTY_MULTIPLIER = 5;
const TIME_BONUS_FACTOR = 0.5;
const LESSON_COMPLETION_BONUS = 50;
const EFFORT_MULTIPLIER = 2;
const LEVEL_UP_THRESHOLD = 100;

function calculateMaterialXP(material, isCompleted, completionTime) {
  if (!isCompleted) return 0;

  let xp = BASE_XP;

  // XP based on material difficulty
  xp += material.level * DIFFICULTY_MULTIPLIER;

  // XP bonus for quick completion (assuming expectedTime is set for each material)
  // For simplicity, we'll use a fixed expected time of 10 minutes (600 seconds)
  const expectedTime = 600;
  if (completionTime && completionTime < expectedTime) {
    xp += (expectedTime - completionTime) * TIME_BONUS_FACTOR;
  }

  return Math.round(xp);
}
const updateProgress = async (req, res) => {
  try {
    const { userId } = req.params;
    const { lessonId, materialId, isCompleted, progress } = req.body;

    if (!mongoose.Types.ObjectId.isValid(userId)) {
      return res.status(400).json({ message: "Invalid user ID" });
    }
    if (!mongoose.Types.ObjectId.isValid(lessonId)) {
      return res.status(400).json({ message: "Invalid lesson ID" });
    }

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Get total number of materials for this lesson
    const totalMaterials = (await Exercise.find({ materialId: materialId }))
      .length;
    // Find the lesson progress or create a new one
    let lessonProgress = user.lessons.find(
      (lp) => lp.lessonId.toString() === lessonId
    );

    if (!lessonProgress) {
      // If lesson progress does not exist, add a new one
      lessonProgress = {
        lessonId,
        progress: 0,
        materialIds: [],
      };
      user.lessons.push(lessonProgress);
    }

    // Check if the materialId is already present
    const materialIndex = lessonProgress.materialIds.findIndex(
      (mp) => mp.id.toString() === materialId
    );

    if (materialIndex !== -1) {
      // Update existing material progress
      if (!lessonProgress.materialIds[materialIndex].completed && isCompleted) {
        lessonProgress.materialIds[materialIndex].completed = isCompleted;
        // Increment progress only if it wasn't completed before
        lessonProgress.progress += (1 / totalMaterials) * 100;
      }
    } else {
      // Add new materialProgress
      lessonProgress.materialIds.push({
        id: materialId,
        completed: isCompleted,
      });
      if (isCompleted) {
        lessonProgress.progress += (1 / totalMaterials) * 100;
      }
    }

    // Ensure progress doesn't exceed 100%
    lessonProgress.progress = Math.min(lessonProgress.progress, 100);

    // Calculate overall user progress (average of all lesson progress)
    const totalProgress = user.lessons.reduce(
      (sum, lesson) => sum + lesson.progress,
      0
    );
    user.xp = progress * 10;
    user.progress =
      user.lessons.length > 0 ? totalProgress / user.lessons.length : 0;

    await user.save();
    res.json({ message: "Lesson progress updated successfully", user });
  } catch (error) {
    console.error("Error updating lesson progress:", error);
    res.status(500).json({ message: "Error updating lesson progress" });
  }
};

const getProgress = async (req, res) => {
  try {
    const progress = await Progress.findOne({ user: req.params.userId })
      .populate("lessonsCompleted")
      .populate("exercisesCompleted");
    if (!progress)
      return res.status(404).json({ message: "Progress not found" });
    res.status(200).json(progress);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
  }
};

module.exports = { updateProgress, getProgress };
