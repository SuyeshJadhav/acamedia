import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";

import socket from "../socket";

const NewPage = () => {
  const [user, setUser] = useState();
  const { id } = useParams();

  const [inputValue, setInputValue] = useState("");

  const [users, setUsers] = useState([
    {
      name: "Aditya",
      userID: "nq0qxaBJV5wsXrmWkHLP",
      chatID: "sStYpjUVDA57phEOHmlp",
      messages: [],
    },
    {
      name: "Suyesh",
      userID: "Ip71HezCXgY3to3JhKAj",
      chatID: "gZLNQnF23wORTU3TQkMz",
      messages: [],
    },
    {
      name: "Dhruv",
      userID: "AXVw4MhGrTPqeAd0vuEG",
      chatID: "sStYpjUVDA57phEOHmlp",
      messages: [],
    },
  ]);

  const handleClick = (user) => {
    setUser(user);
    socket.emit("join", user.chatID);
  };

  socket.auth = { id };
  socket.connect();

  useEffect(() => {
    socket.on("onMessage", (msg) => {
      setUser((prevUser) => {
        return { ...prevUser, msg: [...prevUser.messages, msg] };
      });
      handleMessageReceived(msg);
    });

    return () => {
      socket.off("onMessage");
    };
  }, []);

  const handleMessageReceived = (msg) => {
    setUsers((prevUsers) =>
      prevUsers.map((u) =>
        u.chatID === msg.chatID ? { ...u, messages: [...u.messages, msg] } : u
      )
    );
  };

  const handleInputChange = (event) => {
    setInputValue(event.target.value);
  };

  const handleSendClick = (receiver, msg) => {
    const currentDate = new Date();
    const formattedDate = `${currentDate.getFullYear()}-${(
      currentDate.getMonth() + 1
    )
      .toString()
      .padStart(2, "0")}-${currentDate.getDate().toString().padStart(2, "0")}`;
    const formattedTime = `${currentDate
      .getHours()
      .toString()
      .padStart(2, "0")}:${currentDate
      .getMinutes()
      .toString()
      .padStart(2, "0")}:${currentDate
      .getSeconds()
      .toString()
      .padStart(2, "0")}`;

    const message = {
      message: {
        text: msg,
      },
      sender: id,
      timeStamp: {
        date: formattedDate,
        time: formattedTime,
      },
      chatID: user.chatID,
    };

    setUsers((prevUsers) =>
      prevUsers.map((u) =>
        u.userID === receiver.userID
          ? { ...u, messages: [...u.messages, message] }
          : u
      )
    );

    setUser((prevUser) => {
      return { ...prevUser, messages: [...prevUser.messages, message] };
    });

    setInputValue("");
    socket.emit(`emitMessage`, message);
  };

  // console.log(users);

  return (
    <div>
      {users
        .filter((user) => user.userID !== id)
        .map((user, index) => {
          return (
            <div
              className="border border-red-500 w-64 my-5"
              onClick={() => handleClick(user)}
              key={index}
            >
              {user.name}
            </div>
          );
        })}
      <div className="border border-green-300 space-y-5">
        <h1>CHAT PANEL</h1>

        {user && (
          <div>
            <h1 className="font-bold text-4xl">{user?.name}</h1>
            <div className="border-2 border-green-500 p-10  lg:w-1/2">
              {user?.messages.map((msg, index) => {
                return (
                  <div
                    className={`border border-red-500 ${
                      msg.sender === id ? "text-end" : "text-start"
                    }`}
                    key={index}
                  >
                    {msg.message.text}
                  </div>
                );
              })}
            </div>

            <div className="flex items-center gap-2 w-1/2 p-2">
              <input
                type="text"
                value={inputValue}
                onChange={handleInputChange}
                className="border-2 border-blue-500 w-full"
              />
              <button
                onClick={() => {
                  handleSendClick(user, inputValue);
                }}
                className="border-2 border-blue-500 px-1"
                type="submit"
              >
                Send
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default NewPage;
