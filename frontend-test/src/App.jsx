import React, { useState, useEffect } from "react";
import socket from "./socket";
import Chat from "./components/Chat";

const App = () => {
  const [username, setUsername] = useState("");
  const [showForm, setShowForm] = useState(true);
  const handleSubmit = (e) => {
    e.preventDefault();
    socket.auth = { username };
    socket.connect();
    setShowForm(false);
  };

  const handleUsernameChange = (e) => {
    setUsername(e.target.value);
  };

  useEffect(() => {
    const sessionID = localStorage.getItem("sessionID");

    if (sessionID) {
      setUsernameAlreadySelected(true);
      socket.auth = { sessionID };
      socket.connect();
    }

    socket.on("session", ({ sessionID, userID }) => {
      socket.auth = { sessionID };
      localStorage.setItem("sessionID", sessionID);
      socket.userID = userID;
    });

    socket.on("connect_error", (err) => {
      if (err.message === "invalid username") {
        setUsernameAlreadySelected(false);
      }
    });

    return () => {
      socket.off("connect_error");
    };
  }, []);

  return (
    <div className="p-10">
      {showForm && (
        <form onSubmit={handleSubmit}>
          <input
            type="text"
            placeholder="Username"
            className="border-2"
            value={username}
            onChange={handleUsernameChange}
          />
          <input type="submit" value="Submit" />
        </form>
      )}
      {!showForm && <Chat />}
    </div>
  );
};

export default App;
