// import React, { useState, useEffect } from "react";
// import socket from "../socket";

// const Panel = ({ userID, username }) => {
//   const [messages, setMessages] = useState({});
//   // console.log(messages);
//   const [inputValue, setInputValue] = useState("");
//   const [selectedUser, setSelectedUser] = useState({ userID, username });

//   useEffect(() => {
//     if (!messages[selectedUser.userID]) {
//       setMessages((prevMessages) => ({
//         ...prevMessages,
//         [selectedUser.userID]: [],
//       }));
//     }

//     // Listen for incoming messages

//     // Cleanup listener on component unmount
//     return () => {
//       socket.off("private message");
//     };
//   }, [selectedUser, messages]);

//   const onMessage = (content) => {
//     if (selectedUser) {
//       socket.emit("private message", {
//         content,
//         to: selectedUser.userID,
//       });

//       setMessages((prevMessages) => ({
//         ...prevMessages,
//         [selectedUser.userID]: [
//           ...(prevMessages[selectedUser.userID] || []),
//           { content, fromSelf: true },
//         ],
//       }));

//       setInputValue("");
//     }
//   };

//   const handleInputChange = (event) => {
//     setInputValue(event.target.value);
//   };

//   const handleSendClick = () => {
//     onMessage(inputValue);
//   };

//   return (
//     <div className="border border-red-500 p-10 w-full">
//       <h1>{selectedUser.username}</h1>
//       <div className="flex items-center gap-2">
//         <input
//           type="text"
//           value={inputValue}
//           onChange={handleInputChange}
//           className="border"
//         />
//         <button onClick={handleSendClick} className="border">
//           Send
//         </button>
//       </div>
//       <div>
//         {messages[selectedUser.userID]?.map((message, index) => (
//           <p key={index}>
//             {message.content} {message.fromSelf ? "(You)" : ""}
//           </p>
//         ))}
//       </div>
//     </div>
//   );
// };

// export default Panel;
import React, { useState, useEffect } from "react";
import socket from "../socket";

const Panel = ({ userID, username }) => {
  const [messages, setMessages] = useState({});
  const [inputValue, setInputValue] = useState("");
  const [selectedUser, setSelectedUser] = useState({ userID, username });

  useEffect(() => {
    if (!messages[selectedUser.userID]) {
      setMessages((prevMessages) => ({
        ...prevMessages,
        [selectedUser.userID]: [],
      }));
    }

    // Listen for incoming messages
    const handlePrivateMessage = ({ content, from }) => {
      if (from === selectedUser.userID) {
        setMessages((prevMessages) => ({
          ...prevMessages,
          [selectedUser.userID]: [
            ...(prevMessages[selectedUser.userID] || []),
            { content, fromSelf: false },
          ],
        }));
      }
    };

    socket.on("private message", handlePrivateMessage);

    // Cleanup listener on component unmount
    return () => {
      socket.off("private message", handlePrivateMessage);
    };
  }, [selectedUser, messages]);

  const onMessage = (content) => {
    if (selectedUser) {
      socket.emit("private message", {
        content,
        to: selectedUser.userID,
      });

      setMessages((prevMessages) => ({
        ...prevMessages,
        [selectedUser.userID]: [
          ...(prevMessages[selectedUser.userID] || []),
          { content, fromSelf: true },
        ],
      }));

      setInputValue("");
    }
  };

  const handleInputChange = (event) => {
    setInputValue(event.target.value);
  };

  const handleSendClick = () => {
    onMessage(inputValue);
  };

  return (
    <div className="border border-red-500 p-10 w-full">
      <h1>{selectedUser.username}</h1>
      <div className="flex items-center gap-2">
        <input
          type="text"
          value={inputValue}
          onChange={handleInputChange}
          className="border"
        />
        <button onClick={handleSendClick} className="border">
          Send
        </button>
      </div>
      <div>
        {messages[selectedUser.userID]?.map((message, index) => (
          <p key={index}>
            {message.content} {message.fromSelf ? "(You)" : ""}
          </p>
        ))}
      </div>
    </div>
  );
};

export default Panel;
