export const chatHandler = async (req, res) => {
  try {
    const { message } = req.body;

    if (!message) {
      return res.status(400).json({ message: "Message is required" });
    }

    const lowerMsg = message.toLowerCase();
    let responseText = "";

    // Simple rule-based logic
    if (lowerMsg.includes("hello") || lowerMsg.includes("hi") || lowerMsg.includes("merhaba")) {
      responseText = "Hello! How can I help you with your language learning today?";
    } else if (lowerMsg.includes("how are you") || lowerMsg.includes("nasılsın")) {
      responseText = "I'm just a bot, but I'm functioning perfectly! How are you?";
    } else if (lowerMsg.includes("name") || lowerMsg.includes("adın")) {
      responseText = "I am LingoBot, your personal language assistant.";
    } else if (lowerMsg.includes("thank") || lowerMsg.includes("teşekkür")) {
      responseText = "You're welcome! Keep practicing!";
    } else if (lowerMsg.includes("help") || lowerMsg.includes("yardım")) {
      responseText = "I can help you practice conversation. Just talk to me! try saying 'Hello' or ask me 'What is your name?'.";
    } else {
      // Default echo / encouragement
      responseText = `I heard you say: "${message}". That's interesting! Tell me more.`;
    }

    // Simulate a bit of "thinking" time could be done on client, but we return immediately here.
    return res.status(200).json({ response: responseText });

  } catch (error) {
    console.error("Chat error:", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};
