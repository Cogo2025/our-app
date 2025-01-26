const bcrypt = require('bcrypt');
const { Driver, Owner } = require('../models/owner');

// Driver Registration
const registerDriver = async (req, res) => {
  try {
    const { name, dob, gender, phoneNumber, licenseNumber, email, password } = req.body;

    // Check if email already exists
    const existingDriver = await Driver.findOne({ email });
    if (existingDriver) {
      return res.status(400).json({ error: 'Email already exists' });
    }

    // Hash the password before saving
    const hashedPassword = await bcrypt.hash(password, 10);

    const newDriver = new Driver({
      name, dob, gender, phoneNumber, licenseNumber, email,
      password: hashedPassword, // Save hashed password
    });

    await newDriver.save();
    res.status(201).json({ message: 'Driver registered successfully' });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error', details: error.message });
  }
};

// Owner Registration
const registerOwner = async (req, res) => {
  try {
    const { name, dob, gender, phoneNumber, cinNumber, email, password } = req.body;

    // Check if email already exists
    const existingOwner = await Owner.findOne({ email });
    if (existingOwner) {
      return res.status(400).json({ error: 'Email already exists' });
    }

    // Hash the password before saving
    const hashedPassword = await bcrypt.hash(password, 10);

    const newOwner = new Owner({
      name, dob, gender, phoneNumber, cinNumber, email,
      password: hashedPassword, // Save hashed password
    });

    await newOwner.save();
    res.status(201).json({ message: 'Owner registered successfully' });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error', details: error.message });
  }
};

module.exports = { registerDriver, registerOwner };
