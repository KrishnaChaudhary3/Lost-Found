const express = require('express');
const router = express.Router();
const {
  sendMessage,
  getMessagesBetweenUsers,
  getInbox,
} = require('../controllers/messageController');
const { protect } = require('../middleware/authMiddleware');

router.get('/', protect, getInbox);
router.post('/send', protect, sendMessage);
router.get('/:userId', protect, getMessagesBetweenUsers);

module.exports = router;
