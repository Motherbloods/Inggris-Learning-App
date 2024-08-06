const mongoose = require("mongoose");

const materialSchema = new mongoose.Schema({
  lessonId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Lesson",
  },
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
  level: { type: Number },
});

const Material_Lesson = mongoose.model("Material_Lesson", materialSchema);

module.exports = Material_Lesson;

// const materialdummy = [
//   {
//     lessonId: "66b0554d77e809c869ce20f1",
//     title: "Basic Greetings",
//     content: `
//     **Introduction**: In this lesson, we will learn basic English greetings that are commonly used in everyday conversations. Greetings are essential for starting conversations and making a good impression.

//     **Common Greetings**:
//     - **Hello**: A general greeting that can be used at any time of the day.
//     - **Good Morning**: Used to greet someone in the morning until around noon.
//     - **Good Afternoon**: Used to greet someone from noon until around 6 PM.
//     - **Good Evening**: Used to greet someone after 6 PM until night.

//     **Examples**:
//     - **Hello**: "Hello! How are you today?"
//     - **Good Morning**: "Good morning, Sarah! Did you sleep well?"
//     - **Good Afternoon**: "Good afternoon, Mr. Smith. How is your day going?"
//     - **Good Evening**: "Good evening, Emily. Did you enjoy your dinner?"

//     **Tips**:
//     - Use "Hello" when you are unsure of the time of day.
//     - "Good Morning" can be followed by questions about how the person’s night was.
//     - "Good Evening" is often used in more formal settings.

//     **Practice**:
//     - Practice greeting friends and family using different greetings depending on the time of day.
//     - Record yourself saying each greeting and listen to ensure correct pronunciation.
//   `,
//   exercises:['']
//   },
//   {
//     lessonId: "66b0554d77e809c869ce20f1",
//     title: "Numbers and Counting",
//     content: `
//     **Introduction**: Knowing how to count in English is fundamental for everyday tasks like shopping, telling time, and giving directions. This lesson will cover numbers from 1 to 10.

//     **Numbers**:
//     1: One
//     2: Two
//     3: Three
//     4: Four
//     5: Five
//     6: Six
//     7: Seven
//     8: Eight
//     9: Nine
//     10: Ten

//     **Examples**:
//     - **One**: "I have one apple"
//     - **Two**: "There are two cars in the parking lot."
//     - **Three**: "She bought three books. "

//     **Practice**:
//     - Count objects around you in English.
//     - Write down the numbers and say them aloud.
//     - Practice spelling out the numbers.
//   `,
//   },
//   {
//     lessonId: "66b0554d77e809c869ce20f1",
//     title: "Days of the Week",
//     content: `
//       **Introduction**: Understanding the days of the week is crucial for scheduling and everyday conversation. This lesson will cover the names of the days and how to use them.

//       **Days**:
//       - **Monday**: The first day of the week.
//       - **Tuesday**: The second day of the week.
//       - **Wednesday**: The middle of the week.
//       - **Thursday**: The fourth day of the week.
//       - **Friday**: The last weekday before the weekend.
//       - **Saturday**: The first day of the weekend.
//       - **Sunday**: The last day of the week.

//       **Examples**:
//       - **Monday**: "I have a meeting on Monday."
//       - **Wednesday**: "We go to the gym on Wednesdays."
//       - **Saturday**: "I usually relax on Saturdays."

//       **Tips**:
//       - Use the full name of the day when scheduling appointments or making plans.
//       - In casual conversation, you might refer to the days of the week by their abbreviations (e.g., Mon, Tue).

//       **Practice**:
//       - Write down your weekly schedule and label each day.
//       - Practice saying and writing sentences about your weekly activities.
//     `,
//   },
//   {
//     lessonId: "66b0554d77e809c869ce20f1",
//     title: "Asking for Directions",
//     content: `
//       **Introduction**: Knowing how to ask for directions is essential when navigating new places. This lesson will teach you basic phrases and questions for asking directions.

//       **Common Phrases**:
//       - **"Where is the nearest bank?"**: To ask the location of a nearby bank.
//       - **"How do I get to the subway station?"**: To ask for directions to the subway station.
//       - **"Can you show me on the map?"**: To request a visual direction.
//       - **"Is it far from here?"**: To inquire about the distance.

//       **Examples**:
//       - **"Where is the nearest bank?"**: "The nearest bank is on Main Street, next to the grocery store."
//       - **"How do I get to the subway station?"**: "Go straight, then turn left at the traffic light. The subway station will be on your right."

//       **Tips**:
//       - Use polite phrases like "Excuse me" or "Could you please" when asking for directions.
//       - Carry a map or use a GPS app to help visualize the directions given.

//       **Practice**:
//       - Practice asking for directions to different places in your city.
//       - Role-play asking for directions with a friend or tutor.
//     `,
//   },
//   {
//     lessonId: "66b0554d77e809c869ce20f1",
//     title: "Simple Present Tense",
//     content: `
//       **Introduction**: The simple present tense is used to describe habitual actions, general truths, and routines. This lesson covers the formation and usage of the simple present tense.

//       **Structure**:
//       - **Affirmative Sentences**: Subject + Base Verb (e.g., "She eats breakfast.")
//       - **Negative Sentences**: Subject + do/does + not + Base Verb (e.g., "He does not like coffee.")
//       - **Questions**: Do/Does + Subject + Base Verb? (e.g., "Do they play soccer?")

//       **Examples**:
//       - **Affirmative**: "I read books every day."
//       - **Negative**: "She does not watch TV."
//       - **Question**: "Do you like pizza?"

//       **Tips**:
//       - Use "do" with I, you, we, they and "does" with he, she, it.
//       - Remember that in negative sentences, "not" is used after "do" or "does".

//       **Practice**:
//       - Write sentences about your daily routine using the simple present tense.
//       - Practice forming questions and negative sentences.
//     `,
//   },
//   {
//     lessonId: "66b0554d77e809c869ce20f1",
//     title: "Common Verbs and Their Uses",
//     content: `
//       **Introduction**: Understanding common verbs and their uses is essential for constructing sentences. This lesson covers some frequently used verbs and how to use them.

//       **Common Verbs**:
//       - **To Be**: Used to describe states of being (e.g., "She is happy.")
//       - **To Have**: Used to express possession (e.g., "They have a car.")
//       - **To Do**: Used to perform an action (e.g., "He does his homework.")

//       **Examples**:
//       - **To Be**: "I am a student."
//       - **To Have**: "She has two brothers."
//       - **To Do**: "We do our chores on Saturdays."

//       **Tips**:
//       - Practice using these verbs in different tenses.
//       - Combine them with different subjects to get comfortable with their forms.

//       **Practice**:
//       - Write sentences using each of the common verbs.
//       - Practice making questions and negative sentences with these verbs.
//     `,
//   },
// ];

// mongoose.connect(
//   "mongodb+srv://motherbloodss:XKFofTN9qGntgqbo@cluster0.ejyrmvc.mongodb.net/?retryWrites=true&w=majority",
//   {
//     useNewUrlParser: true,
//     useUnifiedTopology: true,
//   }
// );

// const seedLessons = async () => {
//   try {
//     await Material_Lesson.deleteMany({});
//     await Material_Lesson.insertMany(materialdummy);
//     console.log("Data dummy berhasil dimasukkan ke database!");
//     mongoose.connection.close();
//   } catch (error) {
//     console.error("Error saat memasukkan data dummy:", error);
//   }
// };

// seedLessons();
