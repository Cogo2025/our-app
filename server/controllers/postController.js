const Post = require('../models/post');

// Create a new post
const createPost = async (req, res) => {
  try {
    const { truckType, bsVersion, driverType, timeDuration, location, photos } = req.body;
    const ownerId = req.userId; // Assume user ID is extracted from the token via middleware

    // Create and save the post
    const newPost = new Post({ truckType, bsVersion, driverType, timeDuration, location, photos, ownerId });
    await newPost.save();

    res.status(201).json({ message: 'Post created successfully', post: newPost });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Server error', details: error.message });
  }
};

module.exports = { createPost };
