const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { Driver, Owner } = require('../models/owner');

// Helper function to generate JWT token
const generateToken = (userId) => {
  return jwt.sign({ userId }, process.env.JWT_SECRET, { expiresIn: '1h' });
};

// Driver Login
const loginDriver = async (req, res) => {
  const { email, password } = req.body;
  console.log(`🔹 Driver Login Attempt - Email: ${email}, Password: ${password}`);

  try {
    const driver = await Driver.findOne({ email });

    if (!driver) {
      console.log("❌ Driver not found in DB");
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    console.log(`✅ Driver Found: ${driver.email}`);
    console.log(`🔑 Stored Hashed Password: ${driver.password}`);

    const isMatch = await bcrypt.compare(password, driver.password);
    if (!isMatch) {
      console.log("❌ Password does not match");
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    const token = generateToken(driver._id);
    console.log("✅ Driver Login Successful, Token Generated");

    res.status(200).json({ token });

  } catch (error) {
    console.error("🚨 Server Error:", error);
    res.status(500).json({ error: 'Server error', details: error.message });
  }
};


// Owner Login
const loginOwner = async (req, res) => {
  const { email, password } = req.body;
  console.log(`🔹 Login Attempt - Email: ${email}, Password: ${password}`);

  try {
    // Check if owner exists
    const owner = await Owner.findOne({ email });

    if (!owner) {
      console.log("❌ Owner not found in DB");
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    console.log(`✅ Owner Found: ${owner.email}`);
    console.log(`🔑 Stored Hashed Password: ${owner.password}`);

    // Compare password with hashed password
    const isMatch = await bcrypt.compare(password, owner.password);
    if (!isMatch) {
      console.log("❌ Password does not match");
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    // Generate JWT token
    const token = generateToken(owner._id);
    console.log("✅ Login Successful, Token Generated");

    res.status(200).json({ token });

  } catch (error) {
    console.error("🚨 Server Error:", error);
    res.status(500).json({ error: 'Server error', details: error.message });
  }
};

// Add this new function
const getOwnerProfile = async (req, res) => {
  try {
    const owner = await Owner.findById(req.user.userId);
    if (!owner) {
      return res.status(404).json({ error: 'Owner not found' });
    }
    res.status(200).json({
      name: owner.name,
      email: owner.email,
      phoneNumber: owner.phoneNumber,
      gender: owner.gender,
      dob: owner.dob,
      cinNumber: owner.cinNumber
    });
  } catch (error) {
    res.status(500).json({ error: 'Server error' });
  }
};

module.exports = { loginDriver, loginOwner, getOwnerProfile };
