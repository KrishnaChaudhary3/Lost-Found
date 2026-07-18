const mongoose = require('mongoose');

const reportSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: String,
  type: { type: String, enum: ['lost', 'found'], required: true },
  category: String,
  location: String,
  lat: Number,
  lng: Number,
  imageUrl: String,
  reporterName: String,
  reporterEmail: String,
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Report', reportSchema);
