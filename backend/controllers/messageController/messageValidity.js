const { GoogleGenerativeAI } = require("@google/generative-ai");
require("dotenv").config;

const checkMessageValidity = async message => {
  const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
  const model = genAI.getGenerativeModel({ model: "gemini-pro" });

  const prompt = `Is the following message hateful: "${message}"? Respond with yes or no.`;

  try {
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const text = response.text().toLowerCase();
    return { result: text, status: 200 };
  } catch (error) {
    const regex = new RegExp(`\\bSAFETY\\b`, "gi");
    if (regex.test(error)) return { result: "yes", status: 200 };
    else {
      console.log("Error:-\n", error);
      return { message: "Error checking for message validity", status: 500 };
    }
  }
};

module.exports = checkMessageValidity;
