const express = require('express');
const router = express.Router();
const {
  createReport,
  getReports,
  getMyReports,
  deleteReport,
} = require('../controllers/reportController');
const { protect } = require('../middleware/authMiddleware');

router.get('/', getReports);
router.get('/my', protect, getMyReports);
router.post('/', protect, createReport);
router.delete('/:id', protect, deleteReport);

module.exports = router;
