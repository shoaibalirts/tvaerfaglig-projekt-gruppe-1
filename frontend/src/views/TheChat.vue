<!-- <template>
  <v-card class="mx-auto" max-width="500" height="70vh">
    <v-toolbar color="primary" density="compact" flat>
      <v-toolbar-title>chat room</v-toolbar-title>
      <v-spacer></v-spacer>
      <v-btn icon><v-icon>mdi-account-group</v-icon></v-btn>
    </v-toolbar>

    <v-list class="pa-3" style="overflow-y: auto; height: calc(100% - 110px)">
      <div v-for="(msg, index) in messages" :key="index">
        <v-list-item v-if="msg.isUser" class="d-flex justify-end my-2 pa-0">
          <v-chip color="blue-lighten-1" text-color="white" style="max-width: 80%">
            {{ msg.text }}
          </v-chip>
        </v-list-item>

        <v-list-item v-else class="d-flex justify-start my-2 pa-0">
          <v-chip color="grey-lighten-2" style="max-width: 80%">
            <span class="font-weight-bold mr-2">{{ msg.user }}:</span> {{ msg.text }}
          </v-chip>
        </v-list-item>
      </div>
    </v-list>

    <v-divider></v-divider>

    <v-container class="pa-2">
      <v-row no-gutters>
        <v-col cols="10">
          <v-text-field
            v-model="newMessage"
            label="Type a message..."
            variant="solo"
            hide-details
            clearable
            @keydown.enter="sendMessage"
          ></v-text-field>
        </v-col>
        <v-col cols="2" class="d-flex justify-center align-center">
          <v-btn :disabled="!newMessage" color="primary" icon size="small" @click="sendMessage">
            <v-icon>mdi-send</v-icon>
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-card>
</template> -->
<template>
  <div class="chat-container">
    <h1>Chat Room</h1>
    <div class="messages" id="messageArea">{{ messageFromServer }}</div>
    <div>{{ messageFromClient }}</div>
    <form class="input-container" @submit.prevent="handleChat">
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
const socket = io("http://localhost:3000", {
  withCredentials: true,
});
socket.on("messageFromServer", (message) => {
  console.log("Message from Server: ", message);
});
/*
export default {
  data() {
    return {
      socket: null,
      newMessage: "",
      messages: [
        { text: "Hello, welcome to the chat!", user: "Admin", isUser: false },
        { text: "Testing my message!", user: "You", isUser: true },
      ],
      userId: 1, // Your actual logged-in user ID
    };
  },
  created() {
    // 1. Initialize Socket.IO connection
    this.socket = io("http://localhost:3000");

    // 2. Listen for incoming messages from the server
    this.socket.on("receiveMessage", this.handleIncomingMessage);

    // 3. Optional: Fetch message history from your REST API here
  },
  methods: {
    sendMessage() {
      if (!this.newMessage.trim()) return;

      const messageData = {
        text: this.newMessage,
        senderId: this.userId, // Send your ID
        user: "You", // Replace with actual username from your auth state
      };

      // ⭐️ Emit message to the server ⭐️
      this.socket.emit("sendMessage", messageData);

      // Optimistically add message to local list (optional, but common)
      this.messages.push({ ...messageData, isUser: true });

      this.newMessage = ""; // Clear input
    },

    handleIncomingMessage(messageData) {
      // Only add if it's NOT a message we already added (e.g., sent from a different device)
      if (messageData.senderId !== this.userId) {
        this.messages.push({
          ...messageData,
          isUser: false,
        });
      }
    },
  },
};
*/
export default {
  data() {
    return {
      userInput: "",
      rules: [(v) => !!v || "Field is required"],
      messageFromServer: "",
      messageFromClient: "",
      socket: null,
    };
  },
  methods: {
    async handleChat() {
      const message = this.userInput;
      if (message) {
        this.socket.emit("messageFromClient", message);
        this.socket.on("messa");
      }
      this.userInput = "";
    },
  },
  mounted() {
    this.socket = io("http://localhost:3000");
    this.socket.on("messageFromServer", (message) => {
      this.messageFromServer = message;
    });
  },
};
</script>

<style scoped>
/* 
.v-list {
  display: flex;
  flex-direction: column-reverse; 
}*/

.chat-container {
  max-width: 600px;
  margin: 20px auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.messages {
  height: 300px;
  overflow-y: auto;
  border: 1px solid #eee;
  padding: 10px;
  margin-bottom: 20px;
}

.message {
  margin: 10px 0;
  padding: 8px;
  border-radius: 5px;
}

.server-message {
  background-color: #e3f2fd;
  margin-right: 20%;
}

.client-message {
  background-color: #f5f5f5;
  margin-left: 20%;
}

.input-container {
  display: flex;
  gap: 10px;
}

#messageInput {
  flex: 1;
  padding: 8px;
}

button {
  padding: 8px 20px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}
</style>
