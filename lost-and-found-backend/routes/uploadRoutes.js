const express = require('express');
const router = express.Router();
const upload = require('../middleware/uploadMiddleware');
const { protect } = require('../middleware/authMiddleware');

router.post('/', protect, upload.single('image'), (req, res) => {
  if (!req.file) {
    return res.status(400).json({ message: 'No image file provided' });
  }
  const imageUrl = req.protocol + '://' + req.get('host') + '/uploads/' + req.file.filename;
  res.status(201).json({ imageUrl: imageUrl });
});

module.exports = router;
