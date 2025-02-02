const mongoose = require('mongoose');
const { registrationDB } = require('../config/database');

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

const Driver = registrationDB.model('Driver', driverSchema);
const Owner = registrationDB.model('Owner', ownerSchema);

module.exports = { Driver, Owner };
