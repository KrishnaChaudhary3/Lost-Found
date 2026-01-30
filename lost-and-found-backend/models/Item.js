// // const mongoose = require('mongoose');

// // const itemSchema = new mongoose.Schema({
// //   title: { type: String, required: true },
// //   description: String,
// //   location: String,
// //   category: String,
// //   type: { type: String, enum: ['lost', 'found'], required: true },
// //   user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
// //   date: { type: Date, default: Date.now }
// // });

// // module.exports = mongoose.model('Item', itemSchema);


// const itemSchema = new mongoose.Schema({
//   title: { type: String, required: true },
//   description: String,
//   location: String,
//   category: String,
//   type: { type: String, enum: ['lost', 'found'], required: true },
//   user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
//   date: { type: Date, default: Date.now },
  
//   // ✅ New fields
//   reported: { type: Boolean, default: false },
//   reportReason: { type: String, default: '' }
// });
const mongoose = require('mongoose');

const itemSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: String,
  location: String,
  category: String,
  type: { type: String, enum: ['lost', 'found'], required: true },
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  date: { type: Date, default: Date.now },

  // ✅ Reporting fields
  reported: { type: Boolean, default: false },
  reportReason: { type: String, default: '' }
});

module.exports = mongoose.model('Item', itemSchema);
