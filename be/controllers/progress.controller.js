const Progress = require("../models/progress");

const updateProgress = async (req, res) => {
  try {
    const { userId, lessonId, exerciseId, score } = req.body;
    let progress = await Progress.findOne({ user: userId });
    if (!progress) {
      progress = new Progress({ user: userId });
    }
    if (lessonId) progress.lessonsCompleted.addToSet(lessonId);
    if (exerciseId) progress.exercisesCompleted.addToSet(exerciseId);
    progress.score += score;
    await progress.save();

    // Update user level based on score
    const user = await User.findById(userId);
    user.level = Math.floor(progress.score / 100) + 1; // Example: level up every 100 points
    await user.save();

    res.status(200).json(progress);
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error" });
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
