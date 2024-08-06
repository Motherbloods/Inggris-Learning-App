const mongoose = require("mongoose");

const exerciseSchema = new mongoose.Schema({
  materialId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Material_Lesson",
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

// const exercises = [
//   {
//     materialId: "66b058a55eaa7ede587ca7e3", // Ganti dengan ID material untuk Basic Greetings
//     type: "multiple_choice",
//     question: "What is the common way to greet someone in the morning?",
//     options: ["Good night", "Good morning", "Good evening", "Good afternoon"],
//     correctAnswer: "Good morning",
//     explanation:
//       "In English, 'Good morning' is used to greet someone in the morning hours, typically from sunrise until noon.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e3", // Ganti dengan ID material untuk Basic Greetings
//     type: "fill_in_the_blank",
//     question: "Fill in the blank: '___, how are you?'",
//     correctAnswer: "Hello",
//     explanation:
//       "The word 'Hello' is a common greeting used to start a conversation.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e3", // Ganti dengan ID material untuk Basic Greetings
//     type: "true_false",
//     question:
//       "'Good night' is an appropriate greeting to use when you meet someone in the morning.",
//     correctAnswer: "False",
//     explanation:
//       "'Good night' is typically used to say farewell before going to sleep, not as a greeting in the morning.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e4", // Ganti dengan ID material yang sesuai
//     type: "multiple_choice",
//     question: "What is the number 7 in words?",
//     options: ["Six", "Seven", "Eight", "Nine"],
//     correctAnswer: "Seven",
//     explanation: "The number 7 is written as 'Seven' in words.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e4", // Ganti dengan ID material yang sesuai
//     type: "fill_in_the_blank",
//     question: "The number ___ comes after 5.",
//     correctAnswer: "6",
//     explanation: "After the number 5, the next number is 6.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e4", // Ganti dengan ID material yang sesuai
//     type: "true_false",
//     question: "The number 10 is greater than the number 15.",
//     correctAnswer: "False",
//     explanation: "10 is less than 15, so the statement is false.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e5", // ID untuk "Days of the Week" dari Material_Lesson
//     type: "multiple_choice",
//     question: "What is the first day of the week?",
//     options: ["Monday", "Tuesday", "Wednesday", "Thursday"],
//     correctAnswer: "Monday",
//     explanation:
//       "Monday is considered the first day of the week in most cultures.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e5",
//     type: "fill_in_the_blank",
//     question: "The last day of the week is __.",
//     correctAnswer: "Sunday",
//     explanation:
//       "Sunday is the last day of the week according to most calendars.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e5",
//     type: "true_false",
//     question: "Saturday is the second day of the week.",
//     correctAnswer: "False",
//     explanation: "Saturday is the sixth day of the week, not the second.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e5",
//     type: "multiple_choice",
//     question: "On which day do most people start their work week?",
//     options: ["Monday", "Friday", "Wednesday", "Sunday"],
//     correctAnswer: "Monday",
//     explanation: "Most people start their work week on Monday.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e5",
//     type: "fill_in_the_blank",
//     question: "The day before Friday is __.",
//     correctAnswer: "Thursday",
//     explanation: "Thursday is the day immediately before Friday.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e5",
//     type: "true_false",
//     question: "Wednesday is the middle of the week.",
//     correctAnswer: "True",
//     explanation: "Wednesday is commonly considered the middle of the week.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e6", // ID material "Asking for Directions"
//     type: "multiple_choice",
//     question: "What is the correct phrase to ask for the nearest bank?",
//     options: [
//       "Where is the nearest restaurant?",
//       "Can you tell me how to get to the supermarket?",
//       "Where is the nearest bank?",
//       "How do I get to the airport?",
//     ],
//     correctAnswer: "Where is the nearest bank?",
//     explanation:
//       "To ask for the location of a nearby bank, use the phrase 'Where is the nearest bank?'",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e6", // ID material "Asking for Directions"
//     type: "fill_in_the_blank",
//     question:
//       "Fill in the blank: 'Excuse me, can you tell me how to get to the __?'",
//     correctAnswer: "subway station",
//     explanation:
//       "When asking for directions to a specific location, you might say, 'Excuse me, can you tell me how to get to the subway station?'",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e6", // ID material "Asking for Directions"
//     type: "true_false",
//     question:
//       "True or False: The phrase 'Can you show me on the map?' is used to ask for directions verbally.",
//     correctAnswer: "False",
//     explanation:
//       "The phrase 'Can you show me on the map?' is used to request a visual representation of directions, not verbal directions.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e6", // ID material "Asking for Directions"
//     type: "multiple_choice",
//     question: "How do you ask if a location is far from your current position?",
//     options: [
//       "Is this place nearby?",
//       "Can you tell me the distance to this location?",
//       "Is it far from here?",
//       "How long does it take to get there?",
//     ],
//     correctAnswer: "Is it far from here?",
//     explanation:
//       "To inquire about the distance from your current location, you would ask, 'Is it far from here?'",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e6", // ID material "Asking for Directions"
//     type: "fill_in_the_blank",
//     question:
//       "Fill in the blank: 'Go straight, then turn __ at the traffic light.'",
//     correctAnswer: "left",
//     explanation:
//       "When giving directions, you might say, 'Go straight, then turn left at the traffic light.'",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e7", // ID materi Simple Present Tense
//     type: "multiple_choice",
//     question: "Choose the correct sentence using the simple present tense.",
//     options: [
//       "She going to the store.",
//       "She goes to the store.",
//       "She gone to the store.",
//     ],
//     correctAnswer: "She goes to the store.",
//     explanation:
//       "The correct sentence is 'She goes to the store.' because we use 'goes' with the third person singular subject 'she' in the simple present tense.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e7", // ID materi Simple Present Tense
//     type: "fill_in_the_blank",
//     question:
//       "Fill in the blank with the correct form of the verb in parentheses: 'He ___ (to read) books every evening.'",
//     correctAnswer: "reads",
//     explanation:
//       "The correct form is 'reads' because we use 'reads' with the third person singular subject 'he' in the simple present tense.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e7", // ID materi Simple Present Tense
//     type: "true_false",
//     question: "The sentence 'They do not likes pizza.' is correct.",
//     correctAnswer: "False",
//     explanation:
//       "The correct sentence is 'They do not like pizza.' The verb 'like' should be in its base form after 'do not.'",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e8", // ID materi "Common Verbs and Their Uses"
//     type: "multiple_choice",
//     question: "Which verb is used to express possession?",
//     options: ["To Be", "To Have", "To Do", "To Go"],
//     correctAnswer: "To Have",
//     explanation:
//       "The verb 'To Have' is used to express possession, e.g., 'They have a car.'",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e8", // ID materi "Common Verbs and Their Uses"
//     type: "fill_in_the_blank",
//     question: "She ___ (to be) a teacher.",
//     correctAnswer: "is",
//     explanation: "The correct form of the verb 'To Be' for 'She' is 'is.'",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e8", // ID materi "Common Verbs and Their Uses"
//     type: "true_false",
//     question:
//       "The verb 'To Do' can be used to describe possession. (True/False)",
//     correctAnswer: "False",
//     explanation:
//       "The verb 'To Do' is used to perform actions, not to describe possession. For possession, we use 'To Have.'",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e8", // ID materi "Common Verbs and Their Uses"
//     type: "multiple_choice",
//     question: "Which sentence uses the verb 'To Do' correctly?",
//     options: [
//       "He do his homework.",
//       "He did his homework.",
//       "He does his homework.",
//       "He doing his homework.",
//     ],
//     correctAnswer: "He does his homework.",
//     explanation:
//       "'He does his homework' is the correct usage of the verb 'To Do' in the simple present tense.",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e8", // ID materi "Common Verbs and Their Uses"
//     type: "fill_in_the_blank",
//     question: "They ___ (to have) a big house.",
//     correctAnswer: "have",
//     explanation: "The correct form of the verb 'To Have' for 'They' is 'have.'",
//     level: 1,
//   },
//   {
//     materialId: "66b058a55eaa7ede587ca7e8", // ID materi "Common Verbs and Their Uses"
//     type: "true_false",
//     question:
//       "The verb 'To Be' is used to describe states of being. (True/False)",
//     correctAnswer: "True",
//     explanation:
//       "The verb 'To Be' is used to describe states of being, such as 'She is happy.'",
//     level: 1,
//   },
// ];
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
