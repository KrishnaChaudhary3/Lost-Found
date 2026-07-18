const Report = require('../models/Report');

exports.createReport = async (req, res) => {
  try {
    const { title, description, location, type, category, imageUrl, lat, lng } = req.body;

    const report = await Report.create({
      title: title,
      description: description,
      location: location,
      type: type,
      category: category,
      imageUrl: imageUrl,
      lat: lat,
      lng: lng,
      reporterName: req.user.name,
      reporterEmail: req.user.email,
      user: req.user._id,
    });

    res.status(201).json(report);
  } catch (error) {
    res.status(400).json({ message: 'Failed to create report', error: error.message });
  }
};

exports.getReports = async (req, res) => {
  try {
    const type = req.query.type;
    const filter = {};
    if (type && type !== 'all') filter.type = type;

    const reports = await Report.find(filter).sort({ createdAt: -1 });
    res.json(reports);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch reports', error: error.message });
  }
};

exports.getMyReports = async (req, res) => {
  try {
    const reports = await Report.find({ user: req.user._id }).sort({ createdAt: -1 });
    res.json(reports);
  } catch (error) {
    res.status(500).json({ message: 'Failed to fetch your reports', error: error.message });
  }
};

exports.deleteReport = async (req, res) => {
  try {
    const report = await Report.findById(req.params.id);
    if (!report) return res.status(404).json({ message: 'Report not found' });

    if (!report.user || report.user.toString() !== req.user._id.toString()) {
      return res.status(403).json({ message: 'Not authorized to delete this report' });
    }

    await report.deleteOne();
    res.json({ message: 'Report deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: 'Failed to delete report', error: error.message });
  }
};
