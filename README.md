# quiz_game
The **Quiz Game App** is a fun and interactive mobile app that challenges your knowledge and rewards you with prizes based on your performance. It’s built with **Flutter** and has cool features like a dynamic scoring system, fun animations, scratch cards for prizes, state management, and questions that are fetched from an API.

**Key Features**
- **8-Question Quiz**: Each quiz session consists of 8 questions that are dynamically fetched from an external API, providing a fresh set of questions every time.

- **Dynamic Scoring System:**
  - Score 6 out of 8 to earn 1 point.
  - Score 7 out of 8 to earn 2 points.
  - Score 8 out of 8 to earn 3 points.
  - Scores below 6 do not earn any points.

- **Scratch Card Rewards:**
  - Accumulate 10 points to unlock the scratch card feature and reveal a prize.
  - Prizes may include iPhones, headphones, smartwatches, or a “Better luck next time” message.
  - After scratching the card and claiming your prize, your score is reset to 0, but any extra points over 10 will roll over.

- **Local Score Storage**: The app uses SQFLite to store the scores locally, allowing you to retain your progress between sessions.

- **Interactive Scratch Card**: Use the virtual scratch card to reveal your prize and add a fun, interactive element to the reward system.

- **Celebratory Ribbon Fall**: When the user scores well, a Confetti animation of falling ribbons celebrates their achievement.

- **Animated Home Screen**: The home screen features animated text using Animated Text Kit to create an interactive and engaging experience.

- **Provider for State Management**: Efficient state management using Provider, ensuring seamless UI updates when scores change, rewards are earned, and more.

# Technologies Used
- **Flutter**: Cross-platform mobile development framework.
- **SQFLite**: Local database for storing quiz scores.
- **Provider**: State management package for handling app states efficiently.
- **Scratcher**: Package used to implement the scratch card functionality.
- **Animated Text Kit**: Text animations for a dynamic UI.
- **Confetti Package**: Provides celebratory confetti effects.
- **API Integration**: Questions are fetched from an external API to ensure the quiz content remains fresh.
- 
<img src="https://github.com/pragati-paraagi/quiz_game/blob/master/quiz_Exit.jpg" width="300" />
![image alt](https://github.com/pragati-paraagi/quiz_game/blob/master/quiz_Exit.jpg)
