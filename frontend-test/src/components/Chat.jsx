import React, { useState, useEffect } from "react";
import socket from "../socket";

import Panel from "./Panel";

const Chat = () => {
  const [users, setUsers] = useState([]);
  const [selectedUser, setSelectedUser] = useState();

  useEffect(() => {
    socket.on("users", (users) => {
      users.forEach((user) => {
        user.self = user.userID === socket.id;
        // Ensure messages is an array
        user.messages = user.messages || [];
      });
      setUsers(
        users.sort((a, b) => {
          if (a.self) return -1;
          if (b.self) return 1;
          if (a.username < b.username) return -1;
          return a.username > b.username ? 1 : 0;
        })
      );
    });

    socket.on("user connected", (user) => {
      setUsers((prev) => {
        const userExists = prev.some((u) => u.userID === user.userID);
        if (!userExists) {
          // Ensure messages is an array
          user.messages = user.messages || [];
          return [...prev, user];
        } else {
          return prev;
        }
      });
    });

    return () => {
      socket.off("users");
      socket.off("user connected");
      socket.off("private message");
    };
  }, [selectedUser]);

  return (
    <div className="border border-red-500 text-black">
      {users.map((user) => {
        return (
          <div key={user.userID} onClick={() => setSelectedUser(user)}>
            {user.username} {user.self ? "(You)" : ""}
          </div>
        );
      })}
      {selectedUser && (
        <Panel userID={selectedUser.userID} username={selectedUser.username} />
      )}
    </div>
  );
};

export default Chat;
