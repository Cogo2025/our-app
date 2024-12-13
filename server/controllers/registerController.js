const bcrypt = require('bcrypt');
const { Driver, Owner } = require('../models/owner');

const registerDriver = async (req, res) => {
  try {
    const { name, dob, gender, phoneNumber, licenseNumber, email, password } = req.body;

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Save to database
    const driver = new Driver({
      name,
      dob,
      gender,
      phoneNumber,
      licenseNumber,
      email,
      password: hashedPassword,
    });

    await driver.save();
    res.status(201).json({ message: 'Driver registered successfully!' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to register driver', details: error.message });
  }
};

const registerOwner = async (req, res) => {
  try {
    const { name, dob, gender, phoneNumber, cinNumber, email, password } = req.body;

    // Hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Save to database
    const owner = new Owner({
      name,
      dob,
      gender,
      phoneNumber,
      cinNumber,
      email,
      password: hashedPassword,
    });

    await owner.save();
    res.status(201).json({ message: 'Owner registered successfully!' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to register owner', details: error.message });
  }
};

module.exports = { registerDriver, registerOwner };
