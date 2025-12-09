<template>
  <div class="chat-container">
    <tool-bar toolbarTitle="Chat Room" />
    <div class="messages" id="messageArea">
      <div
        v-for="(msg, index) in messages"
        :key="index"
        :class="['message', msg.sender === 'client' ? 'client-message' : 'server-message']"
      >
        {{ msg.message }}
      </div>
    </div>
    <form class="input-container" @submit.prevent="handleSendMessage">
      <input
        type="text"
        id="messageInput"
        v-model="userInput"
        :rules="rules"
        placeholder="Type your message..."
      />
      <button type="submit" class="send-button">Send</button>
    </form>
  </div>
</template>
<script>
import { io } from "socket.io-client";
import ToolBar from "@/components/layout/ToolBar.vue";

const socket = io("http://localhost:3000", {
  withCredentials: true,
});
socket.on("messageFromServer", (message) => {
  console.log("Message from Server: ", message);
});
socket.emit("messageFromClient", (message) => {
  console.log("MessageFromClient", message);
});
socket.on("messageFromServerReceivedFromClient", (message) => {
  console.log("messageFromServerReceivedFromClient: ", message);
});

export default {
  components: {
    ToolBar,
  },
  data() {
    return {
      userInput: "",
      messages: [],
      rules: [(v) => !!v || "Field is required"],
      messageFromServer: "",
      messageFromClient: "",
      sender: "",
      socket: null,
    };
  },
  methods: {
    // sending message to server from client
    handleSendMessage() {
      if (!this.userInput) return;

      this.addMessage(this.userInput, "client");
      this.socket.emit("messageFromClient", this.userInput);
      this.userInput = "";
    },
    addMessage(message, sender) {
      this.messages.push({
        message: message,
        sender: sender,
      });
    },
  },

  mounted() {
    this.socket = io("http://localhost:3000", {
      withCredentials: true,
    });
    // listening an event from the server
    // receiving message to client from server

    this.socket.on("messageFromServer", (message) => {
      this.addMessage(message, "server");
    });
  },
};
</script>

<style scoped>
.chat-container {
  width: 100%;
  max-width: 480px;
  height: 80vh;
  margin: 0 auto;

  padding: 0;
  display: flex;
  flex-direction: column;
  /* border-radius: 12px; */
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  background: #ffffff;
  overflow: hidden;
}

/* Header */
h1 {
  margin: 0;
  padding: 15px 20px;
  text-align: center;
  background: #1976d2;
  color: white;
  font-size: 20px;
  font-weight: 500;
}

/* Message list */
.messages {
  flex: 1;
  padding: 15px;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
  gap: 10px;
  background: #f7f9fc;
}

/* General message bubble */
.message {
  max-width: 75%;
  padding: 10px 14px;
  border-radius: 15px;
  font-size: 15px;
  line-height: 1.4;
  word-wrap: break-word;
}

/* Server bubbles (left-aligned) */
.server-message {
  align-self: flex-start;
  background: #e1f0ff;
  border-top-left-radius: 5px;
}

/* Client bubbles (right-aligned) */
.client-message {
  align-self: flex-end;
  background: #dfffe2;
  border-top-right-radius: 5px;
}

/* Input section */
.input-container {
  display: flex;
  gap: 10px;
  padding: 12px;
  background: #fff;
  border-top: 1px solid #ddd;
}

#messageInput {
  flex: 1;
  padding: 10px 14px;
  font-size: 15px;
  border: 1px solid #ccc;
  border-radius: 8px;
  outline: none;
  transition: 0.2s;
}

#messageInput:focus {
  border-color: #1976d2;
  box-shadow: 0 0 0 2px rgba(25, 118, 210, 0.2);
}

/* Send button */
.send-button {
  padding: 10px 18px;
  background: #1976d2;
  color: white;
  font-size: 14px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: 0.2s;
  font-weight: 500;
}

.send-button:hover {
  background: #0d60b3;
}
</style>
