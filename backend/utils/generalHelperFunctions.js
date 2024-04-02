/*********************************************************
              Get Current GMT Date and Time
*********************************************************/
const getTimeStamp = () => {
  const currentDateTime = new Date().toISOString();
  let [date, time] = currentDateTime.split("T");
  [time, _] = time.split(".");

  date = date.split("-").join("");
  time = time.split(":").join("");

  const timeStamp = date.concat(time);
  return timeStamp;
};

module.exports = { getTimeStamp };
