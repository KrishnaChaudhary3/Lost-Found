const Item = require('../models/Item');

exports.addItem = async (req, res) => {
  try {
    const item = await Item.create({ ...req.body, user: req.user._id });
    res.status(201).json(item);
  } catch (error) {
    res.status(400).json({ message: 'Failed to add item', error: error.message });
  }
};

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

exports.getItemById = async (req, res) => {
  try {
    const item = await Item.findById(req.params.id).populate('user', 'name email');
    if (!item) return res.status(404).json({ message: 'Item not found' });
    res.json(item);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch item', error: error.message });
  }
};

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

exports.getMyItems = async (req, res) => {
  try {
    const items = await Item.find({ user: req.user._id });
    res.json(items);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch your items', error: error.message });
  }
};

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
