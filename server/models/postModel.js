const mongoose = require('mongoose');

const postSchema = new mongoose.Schema({
  truckType: String,
  bsVersion: String,
  driverType: String,
  timeDuration: String,
  location: String,
  photos: [String], // Path of images
  owner: { type: mongoose.Schema.Types.ObjectId, ref: 'Owner' }, // Reference to Owner
}, { timestamps: true });

const Post = mongoose.model('Post', postSchema);

module.exports = Post;
