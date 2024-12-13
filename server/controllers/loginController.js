const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { Driver, Owner } = require('../models/owner');

// Helper function to generate JWT token
const generateToken = (userId) => {
  return jwt.sign({ userId }, 'your_jwt_secret', { expiresIn: '1h' });
};

// Driver Login
const loginDriver = async (req, res) => {
  const { email, password } = req.body;

  try {
    // Check if the driver exists
    const driver = await Driver.findOne({ email });
    if (!driver) {
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    // Compare password with stored hashed password
    const isMatch = await bcrypt.compare(password, driver.password);
    if (!isMatch) {
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    // Generate JWT token
    const token = generateToken(driver._id);
    res.status(200).json({ token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error', details: error.message });
  }
};

// Owner Login
const loginOwner = async (req, res) => {
  const { email, password } = req.body;

  try {
    // Check if the owner exists
    const owner = await Owner.findOne({ email });
    if (!owner) {
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    // Compare password with stored hashed password
    const isMatch = await bcrypt.compare(password, owner.password);
    if (!isMatch) {
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    // Generate JWT token
    const token = generateToken(owner._id);
    res.status(200).json({ token });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error', details: error.message });
  }
};

module.exports = { loginDriver, loginOwner };
