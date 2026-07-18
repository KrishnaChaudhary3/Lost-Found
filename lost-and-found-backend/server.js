const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const cors = require('cors');
const path = require('path');

const authRoutes = require('./routes/authRoutes');
const itemRoutes = require('./routes/itemRoutes');
const messageRoutes = require('./routes/messageRoutes');
const reportRoutes = require('./routes/reportRoutes');
const uploadRoutes = require('./routes/uploadRoutes');

console.log('authRoutes:', typeof authRoutes);
console.log('itemRoutes:', typeof itemRoutes);
console.log('messageRoutes:', typeof messageRoutes);
console.log('reportRoutes:', typeof reportRoutes);
console.log('uploadRoutes:', typeof uploadRoutes);

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.use('/api/auth', authRoutes);
app.use('/api/items', itemRoutes);
app.use('/api/messages', messageRoutes);
app.use('/api/users', authRoutes);
app.use('/api/reports', reportRoutes);
app.use('/api/upload', uploadRoutes);

app.get('/', (req, res) => {
  res.send('Lost & Found API is running');
});

mongoose.connect(process.env.MONGO_URI)
.then(() => {
  console.log('MongoDB connected successfully');
  app.listen(5000, '0.0.0.0', () => {
    console.log('Server started on http://0.0.0.0:5000');
  });
})
.catch((err) => {
  console.error('MongoDB connection error:', err.message);
});
