const express = require('express');
const { createPost } = require('../controllers/postController');
const verifyToken = require('../middleware/auth'); // Middleware to verify the user token

const router = express.Router();

// Route for creating a post
router.post('/owner/posts', verifyToken, createPost);

module.exports = router;
