//--------------- get current GMT date and time -------------------------
const getTimeStamp = () => {
  const currentDateTime = new Date().toISOString();
  let [date, time] = currentDateTime.split("T");
  [time, _] = time.split(".");

  return { date, time };
}

module.exports = {getTimeStamp};