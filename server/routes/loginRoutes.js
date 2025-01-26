const express = require('express');
const { loginDriver, loginOwner } = require('../controllers/loginController'); 

const router = express.Router();

const verifyToken = require('../middleware/auth');

router.post('/driver/login', loginDriver);


router.post('/owner/login', loginOwner);

module.exports = router;