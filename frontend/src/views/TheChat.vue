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
    <div class="user-list">
      <h3>Select a user to chat with:</h3>
      <div
        v-for="user in userList"
        :key="user.user_id"
        class="user-item"
        :class="{ active: activeChatUserId === user.user_id }"
        @click="selectUser(user.user_id)"
      >
        {{ user.user_name }}
      </div>
    </div>
    <div v-if="activeChatUserId" class="active-chat">
      Chatting with user ID: {{ activeChatUserId }}
    </div>
  </div>
</template>

<!-- <template>
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
</template> -->
<script>
import { io } from "socket.io-client";
import ToolBar from "@/components/layout/ToolBar.vue";
import { getUsers, getMessages } from "../api.js";
// getUsers();

// import { Timestamp } from "firebase/firestore";

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
// handle server deliveredMessage with acknowledgement
socket.on("deliveredMessage", (message, callback) => {
  // send acknowledgement back to the server
  console.log("Received delivery of the message", message);
  callback({
    status: "received",
    message: "Thanks for the delivery of the message",
    Timestamp: new Date(),
  });
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
      currentUserId: null,
      activeChatUserId: null,
      userList: [],
    };
  },
  /*
  methods: {
    // sending message to server from client
    handleSendMessage() {
      if (!this.userInput) return;

      this.addMessage(this.userInput, "client");
      // this.socket.emit("messageFromClient", this.userInput);
      this.socket.emit("privateMessage", {
        // receiver_id: this.currentUserId === 10 ? 5 : 10,
        receiver_id: this.activeChatUserId,
        message: this.userInput,
      });

      this.userInput = "";
    },
    addMessage(message, sender) {
      this.messages.push({
        message: message,
        sender: sender,
      });
    },
  },
  */
  methods: {
    async selectUser(userId) {
      this.activeChatUserId = userId;
      const history = await getMessages(this.currentUserId, userId);
      // this.messages = []; // clear previous messages
      this.messages = history.map((m) => ({
        message: m.message,
        sender: m.sender_user_id === this.currentUserId ? "client" : "server",
      }));
    },
    handleSendMessage() {
      if (!this.userInput || !this.activeChatUserId) return;

      this.addMessage(this.userInput, "client");
      this.socket.emit("privateMessage", {
        receiver_id: this.activeChatUserId,
        message: this.userInput,
      });
      this.userInput = "";
    },
    addMessage(message, sender) {
      this.messages.push({ message, sender });
    },
  },
  async mounted() {
    this.socket = io("http://localhost:3000", {
      withCredentials: true,
    });
    // listening an event from the server
    // receiving message to client from server
    const token = this.$cookies.get("token");
    const payload = JSON.parse(atob(token.split(".")[1]));
    this.currentUserId = payload.id;
    const users = await getUsers();
    // getUsers().then((users) => {
    this.userList = users.filter((u) => u.user_id !== this.currentUserId);
    // });
    console.log("Loaded users:", this.userList);
    // if (this.currentUserId === 5) {
    //   this.activeChatUserId = 10;
    // } else if (this.currentUserId === 10) {
    //   this.activeChatUserId = 5;
    // }
    this.socket.on("messageFromServer", (msg) => {
      const isFromMe = msg.sender_id === this.currentUserId;
      this.addMessage(msg.message, isFromMe ? "client" : "server");
      // this.addMessage(message, "server");
    });
  },
};
</script>

<style scoped>
.user-list {
  padding: 10px;
  background: #f0f4f8;
  border-bottom: 1px solid #ccc;
}

.user-item {
  padding: 8px 12px;
  margin-bottom: 5px;
  background: #e1f0ff;
  border-radius: 6px;
  cursor: pointer;
  transition: background 0.2s;
}

.user-item:hover {
  background: #cce4ff;
}

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
.user-item.active {
  background: #1976d2;
  color: white;
  font-weight: bold;
}
.active-chat {
  padding: 10px;
  background: #e8f0fe;
  border-bottom: 1px solid #ccc;
  font-weight: 600;
  color: #333;
}
</style>
