const nodemailer = require("nodemailer");

const mailSender = async (otp) => {
  try {
    const transporter = nodemailer.createTransport({
      host: "smtp.gmail.com",
      port: 465,
      secure: true,
      auth: {
        user: process.env.NODEMAILER_USERNAME,
        pass: process.env.NODEMAILER_PASSWORD,
      },
    });

    const msg = {
      from: `"Acamedia Team" <${process.env.NODEMAILER_USERNAME}>`,
      to: "dedhia.dr@somaiya.edu",
      subject: "Sending Email using Node.js/Node Mailer",
      text: `OTP is ${otp}`,
    };

    transporter.sendMail(msg, (error, info) => {
      if (error) {
        console.log(error);
      } else {
        console.log("Email sent: " + info.response);
      }
    });
  } catch (error) {
    console.log(error);
  }
};

module.exports = mailSender;
