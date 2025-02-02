const express = require('express');
const { loginDriver, loginOwner, getOwnerProfile } = require('../controllers/loginController'); 

const router = express.Router();

const verifyToken = require('../middleware/auth');

router.post('/driver/login', loginDriver);


router.post('/owner/login', loginOwner);

router.get('/owner/profile', verifyToken, getOwnerProfile);

module.exports = router;