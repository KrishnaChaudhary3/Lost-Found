const Message = require('../models/Message');
const mongoose = require('mongoose');

exports.sendMessage = async function (req, res) {
  try {
    const receiverId = req.body.receiverId;
    const content = req.body.content;

    if (!receiverId || !content) {
      return res.status(400).json({ message: 'receiverId and content are required' });
    }

    const message = await Message.create({
      sender: req.user._id,
      receiver: receiverId,
      content: content,
    });

    res.status(201).json(message);
  } catch (error) {
    res.status(400).json({ message: 'Failed to send message', error: error.message });
  }
};

exports.getMessagesBetweenUsers = async function (req, res) {
  try {
    const messages = await Message.find({
      $or: [
        { sender: req.user._id, receiver: req.params.userId },
        { sender: req.params.userId, receiver: req.user._id }
      ]
    }).sort({ createdAt: 1 });

    res.json(messages);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch messages', error: error.message });
  }
};

exports.getInbox = async function (req, res) {
  try {
    const userId = new mongoose.Types.ObjectId(req.user._id);

    const inbox = await Message.aggregate([
      { $match: { $or: [{ sender: userId }, { receiver: userId }] } },
      { $sort: { createdAt: -1 } },
      {
        $group: {
          _id: {
            $cond: [{ $eq: ['$sender', userId] }, '$receiver', '$sender']
          },
          lastMessage: { $first: '$content' },
          lastTimestamp: { $first: '$createdAt' }
        }
      },
      {
        $lookup: {
          from: 'users',
          localField: '_id',
          foreignField: '_id',
          as: 'otherUser'
        }
      },
      { $unwind: '$otherUser' },
      {
        $project: {
          userId: '$_id',
          name: '$otherUser.name',
          email: '$otherUser.email',
          lastMsg: '$lastMessage',
          timestamp: '$lastTimestamp'
        }
      },
      { $sort: { timestamp: -1 } }
    ]);

    res.json(inbox);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch inbox', error: error.message });
  }
};
