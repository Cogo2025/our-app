const mongoose = require('mongoose');

const driverSchema = new mongoose.Schema({
  name: String,
  dob: Date,
  gender: String,
  phoneNumber: String,
  licenseNumber: String,
  email: { type: String, unique: true },
  password: String,
});

const ownerSchema = new mongoose.Schema({
  name: String,
  dob: Date,
  gender: String,
  phoneNumber: String,
  cinNumber: String,
  email: { type: String, unique: true },
  password: String,
});

const Driver = mongoose.model('Driver', driverSchema);
const Owner = mongoose.model('Owner', ownerSchema);

module.exports = { Driver, Owner };
