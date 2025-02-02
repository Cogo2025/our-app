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
  userType: { type: String, enum: ['driver', 'owner'], required: true },
}, { timestamps: true });

const DriverPost = postDB.model('DriverPost', postSchema, 'driver-posts');
const OwnerPost = postDB.model('OwnerPost', postSchema, 'owner-posts');

module.exports = { DriverPost, OwnerPost };





