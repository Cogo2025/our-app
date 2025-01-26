const express = require('express');
const { registerDriver, registerOwner } = require('../controllers/registerController');

const router = express.Router();
const verifyToken = require('../middleware/auth');

// Driver Registration
router.post('/driver/register', registerDriver);

// Owner Registration
router.post('/owner/register', registerOwner);

// Driver Login


module.exports = router;
