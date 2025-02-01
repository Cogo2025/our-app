const express = require('express');
const { createPost } = require('../controllers/postController');
const verifyToken = require('../middleware/auth'); // Import the auth middleware
const upload = require('../middleware/upload');
const Post = require('../models/postModel');

const router = express.Router();

// Route for creating a new post with file upload
router.post('/posts', verifyToken, upload.array('photos', 5), createPost);

// Add this new route to get posts for the authenticated user
router.get('/posts/my-posts', verifyToken, async (req, res) => {
  try {
    const posts = await Post.find({ owner: req.user._id })
      .sort({ createdAt: -1 })
      .select('truckType bsVersion driverType timeDuration location photos owner'); // Explicitly select fields

    // Transform the posts to ensure all required fields are present
    const transformedPosts = posts.map(post => ({
      _id: post._id,
      truckType: post.truckType || '',
      bsVersion: post.bsVersion || '',
      driverType: post.driverType || '',
      timeDuration: post.timeDuration || '',
      location: post.location || '',
      photos: post.photos || [],
      owner: post.owner,
    }));

    console.log('Sending posts:', transformedPosts); // Debug log
    res.json(transformedPosts);
  } catch (error) {
    console.error('Error fetching posts:', error);
    res.status(500).json({ error: 'Server error' });
  }
});

module.exports = router;


