const express = require('express');
const router = express.Router();
const {
  addItem,
  getItems,
  getItemById,
  deleteItem,
  getMyItems,
  reportItem,
} = require('../controllers/itemController');
const { protect } = require('../middleware/authMiddleware');

router.get('/', getItems);
router.get('/my', protect, getMyItems);
router.get('/:id', getItemById);
router.post('/', protect, addItem);
router.delete('/:id', protect, deleteItem);
router.post('/:id/report', protect, reportItem);

module.exports = router;
