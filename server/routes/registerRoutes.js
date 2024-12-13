const express = require('express');
const { registerDriver, registerOwner } = require('../controllers/registerController');
const { loginDriver, loginOwner } = require('../controllers/loginController'); // Import login functions
const router = express.Router();
const verifyToken = require('../middleware/auth');

// Driver Registration
router.post('/driver/register', registerDriver);

// Owner Registration
router.post('/owner/register', registerOwner);

// Driver Login
router.post('/driver/login', loginDriver);

// Owner Login
router.post('/owner/login', loginOwner);

module.exports = router;
