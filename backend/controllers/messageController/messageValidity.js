const {
  GoogleGenerativeAI,
  HarmCategory,
  HarmBlockThreshold
} = require("@google/generative-ai");
const { statusCodes } = require( "../../utils/variableNames" );
require("dotenv").config;

/*********************************************************
        Check validity of message using Gemini API
*********************************************************/
const checkMessageValidity = async (message, role) => {
  const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

  // remove safety settings
  const safetySettings = [
    {
      category: HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT,
      threshold: HarmBlockThreshold.BLOCK_NONE
    },
    {
      category: HarmCategory.HARM_CATEGORY_HARASSMENT,
      threshold: HarmBlockThreshold.BLOCK_NONE
    },
    {
      category: HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT,
      threshold: HarmBlockThreshold.BLOCK_NONE
    },
    {
      category: HarmCategory.HARM_CATEGORY_HATE_SPEECH,
      threshold: HarmBlockThreshold.BLOCK_NONE
    }
  ];

  const model = genAI.getGenerativeModel({
    model: "gemini-pro",
    safetySettings
  });

  // set rules for each rule
  const teacherRules = `These are the teacher's rules:\n
    1. Order or demand students to do something.\n
    2. Can be rude sometimes.`;

  const studentRules = `These are the student's rules:\n
    1. Be polite to the teacher.\n
    2. Can be straightforward sometimes but not in a way that it becomes too rude.`;

  const prompt = `We are making a chat app for easy communication between students and teachers. Consider that all student teacher relations are friendly. You have to tell me if the message is not aggressive, abusive or hateful. It should also not be an unacceptable relation, like romantic relations. It is ok if the message is neutral or contains emojis that don't violate the rule. Symbols and characters like '.' ',' '#' are acceptable until they are not getting used to make an unacceptable image or text. Period (.) is acceptable.\n
  ${teacherRules}\n ${studentRules}\n
  Respond only with a yes or no and then the reason in next line. 
  The role field tells who is sending the message. So if role is student, then the receiever is teacher and vice versa.
  \nmessage: "${message} \nrole: ${role}"? \n
  The response format should be: \n
  <yes/no>\n<reason>`;

  // get response
  try {
    const result = await model.generateContent(prompt);
    const response = await result.response;
    const answer = response.text();
    const [isValid, reason] = answer.split("\n" || "," || ".");
    if(isValid.toLowerCase() === "no") return {message: reason, status: statusCodes.INAPPROPRIATE_MESSAGE};
    else return {status: statusCodes.APPROPRIATE_MESSAGE};
  } catch (error) {
    console.log(`Error validating message:- \n${error}`);
    return { message: "Error checking for message validity", status: 500 };
  }
};

module.exports = checkMessageValidity;
