// const Item = require('../models/Item');

// // @desc    Add a new lost/found item
// // @route   POST /api/items
// // @access  Private
// exports.addItem = async (req, res) => {
//   try {
//     const item = await Item.create({ ...req.body, user: req.user._id });
//     res.status(201).json(item);
//   } catch (error) {
//     res.status(400).json({ message: 'Failed to add item', error: error.message });
//   }
// };

// // @desc    Get all items (with optional filters)
// // @route   GET /api/items?type=lost&location=gla
// // @access  Public
// exports.getItems = async (req, res) => {
//   try {
//     const { type, location } = req.query;
//     const filter = {};

//     if (type) filter.type = type;
//     if (location) filter.location = new RegExp(location, 'i');

//     const items = await Item.find(filter).populate('user', 'name email');
//     res.json(items);
//   } catch (error) {
//     res.status(500).json({ message: 'Failed to fetch items', error: error.message });
//   }
// };

// // @desc    Get a single item by ID
// // @route   GET /api/items/:id
// // @access  Public
// exports.getItemById = async (req, res) => {
//   try {
//     const item = await Item.findById(req.params.id).populate('user', 'name email');
//     if (!item) return res.status(404).json({ message: 'Item not found' });
//     res.json(item);
//   } catch (error) {
//     res.status(500).json({ message: 'Failed to fetch item', error: error.message });
//   }
// };

// // @desc    Delete an item (only owner can delete)
// // @route   DELETE /api/items/:id
// // @access  Private
// exports.deleteItem = async (req, res) => {
//   try {
//     const item = await Item.findById(req.params.id);
//     if (!item || item.user.toString() !== req.user._id.toString()) {
//       return res.status(403).json({ message: 'Not authorized' });
//     }
//     await item.deleteOne();
//     res.json({ message: 'Item deleted successfully' });
//   } catch (error) {
//     res.status(500).json({ message: 'Failed to delete item', error: error.message });
//   }
// };

// // @desc    Get items posted by the logged-in user
// // @route   GET /api/items/my
// // @access  Private
// exports.getMyItems = async (req, res) => {
//   try {
//     const items = await Item.find({ user: req.user._id });
//     res.json(items);
//   } catch (error) {
//     res.status(500).json({ message: 'Failed to fetch your items', error: error.message });
//   }
// };
const Item = require('../models/Item');

// @desc    Add a new lost/found item
// @route   POST /api/items
// @access  Private
exports.addItem = async (req, res) => {
  try {
    const item = await Item.create({ ...req.body, user: req.user._id });
    res.status(201).json(item);
  } catch (error) {
    res.status(400).json({ message: 'Failed to add item', error: error.message });
  }
};

// @desc    Get all items (with optional filters)
// @route   GET /api/items?type=lost&location=gla
// @access  Public
exports.getItems = async (req, res) => {
  try {
    const { type, location } = req.query;
    const filter = {};

    if (type) filter.type = type;
    if (location) filter.location = new RegExp(location, 'i');

    const items = await Item.find(filter).populate('user', 'name email');
    res.json(items);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch items', error: error.message });
  }
};

// @desc    Get a single item by ID
// @route   GET /api/items/:id
// @access  Public
exports.getItemById = async (req, res) => {
  try {
    const item = await Item.findById(req.params.id).populate('user', 'name email');
    if (!item) return res.status(404).json({ message: 'Item not found' });
    res.json(item);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch item', error: error.message });
  }
};

// @desc    Delete an item (only owner can delete)
// @route   DELETE /api/items/:id
// @access  Private
exports.deleteItem = async (req, res) => {
  try {
    const item = await Item.findById(req.params.id);
    if (!item || item.user.toString() !== req.user._id.toString()) {
      return res.status(403).json({ message: 'Not authorized' });
    }
    await item.deleteOne();
    res.json({ message: 'Item deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Failed to delete item', error: error.message });
  }
};

// @desc    Get items posted by the logged-in user
// @route   GET /api/items/my
// @access  Private
exports.getMyItems = async (req, res) => {
  try {
    const items = await Item.find({ user: req.user._id });
    res.json(items);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch your items', error: error.message });
  }
};

// ✅ @desc    Report an item
// ✅ @route   POST /api/items/:id/report
// ✅ @access  Private
exports.reportItem = async (req, res) => {
  try {
    const item = await Item.findById(req.params.id);
    if (!item) {
      return res.status(404).json({ message: 'Item not found' });
    }

    item.reported = true;
    item.reportReason = req.body.reason || 'No reason provided';
    await item.save();

    res.json({ message: 'Item reported successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Failed to report item', error: error.message });
  }
};
