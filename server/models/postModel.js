const mongoose = require('mongoose');
const { postDB } = require('../config/database');

const postSchema = new mongoose.Schema({
  truckType: String,
  bsVersion: String,
  driverType: String,
  timeDuration: String,
  location: String,
  photos: [String], // Path of images
  owner: { type: mongoose.Schema.Types.ObjectId, ref: 'Owner' }, // Reference to Owner
  userType: { type: String, default: 'owner' },
}, { timestamps: true });

const OwnerPost = postDB.model('OwnerPost', postSchema, 'owner');

module.exports = { OwnerPost };





