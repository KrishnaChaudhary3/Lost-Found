// models/Report.js
const mongoose = require('mongoose');

const reportSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
  },
  description: String,
  type: {
    type: String,
    enum: ['lost', 'found'],
    required: true,
  },
  category: String,
  location: String,
  reporterName: String,
  reporterEmail: String,
  createdAt: {
    type: Date,
    default: Date.now,
  }
});

module.exports = mongoose.model('Report', reportSchema);
