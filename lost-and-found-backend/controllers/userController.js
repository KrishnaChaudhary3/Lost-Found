const Item = require('../models/Item');

exports.getUserProfile = async (req, res) => {
  try {
    const user = req.user;
    const items = await Item.find({ user: user._id }).sort({ createdAt: -1 });

    res.status(200).json({
      email: user.email,
      items: items,
    });
  } catch (error) {
    console.error("Error fetching profile:", error.message);
    res.status(500).json({ message: "Server error" });
  }
};
