const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
  truckType: { type: String, required: true },
  bsVersion: { type: String, required: true },
  driverType: { type: String, required: true },
  timeDuration: { type: String, required: true },
  location: { type: String, required: true },
  photos: { type: [String], required: true }, // Array of photo URLs
  ownerId: { type: mongoose.Schema.Types.ObjectId, ref: 'Owner', required: true }, // Reference to the owner
}, { timestamps: true });

const Post = mongoose.model('Post', postSchema);

module.exports = Post;
