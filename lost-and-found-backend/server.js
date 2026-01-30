// const express = require('express');
// const mongoose = require('mongoose');
// const dotenv = require('dotenv');
// const cors = require('cors');

// // Route imports
// const authRoutes = require('./routes/authRoutes');
// const itemRoutes = require('./routes/itemRoutes');
// const messageRoutes = require('./routes/messageRoutes');
// const userRoutes = require('./routes/userRoutes');
// const reportRoutes = require('./routes/reportRoutes'); // 👈 NEW


// // Load environment variables
// dotenv.config();

// // Create Express app
// const app = express();

// // Middleware
// app.use(cors());
// app.use(express.json());

// // Routes
// app.use('/api/auth', authRoutes);
// app.use('/api/items', itemRoutes);
// app.use('/api/messages', messageRoutes);
// app.use('/api/users', userRoutes);
// app.use('/api/reports', reportRoutes); // 


// // Basic route to test API is running
// app.get('/', (req, res) => {
//   res.send('Lost & Found API is running');
// });

// // Connect to MongoDB and start server
// mongoose.connect(process.env.MONGO_URI, {
//   useNewUrlParser: true,
//   useUnifiedTopology: true
// })
// .then(() => {
//   console.log('✅ MongoDB connected successfully');
//   // app.listen(5000, () => {
//   //   console.log('🚀 Server started on http://localhost:5000');
//   // });
//   app.listen(5000, '0.0.0.0', () => {
//   console.log('🚀 Server started on http://0.0.0.0:5000');
// });
// })
// .catch((err) => {
//   console.error('❌ MongoDB connection error:', err.message);
// });


const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const cors = require('cors');

// Route imports
const authRoutes = require('./routes/authRoutes'); // ✅ renamed from userRoutes
const itemRoutes = require('./routes/itemRoutes');
const messageRoutes = require('./routes/messageRoutes');
const reportRoutes = require('./routes/reportRoutes');

// Load environment variables
dotenv.config();

// Create Express app
const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/auth', authRoutes); // 👈 use this if you want /api/auth/login, etc.
app.use('/api/items', itemRoutes);
app.use('/api/messages', messageRoutes);
app.use('/api/users', authRoutes); // ✅ replaces userRoutes
app.use('/api/reports', reportRoutes);

// Basic route to test API is running
app.get('/', (req, res) => {
  res.send('Lost & Found API is running');
});

// Connect to MongoDB and start server
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
.then(() => {
  console.log('✅ MongoDB connected successfully');
  app.listen(5000, '0.0.0.0', () => {
    console.log('🚀 Server started on http://0.0.0.0:5000');
  });
})
.catch((err) => {
  console.error('❌ MongoDB connection error:', err.message);
});
