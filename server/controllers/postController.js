<<<<<<< HEAD
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
=======
const Post = require('../models/postModel');

// Create a post (for owners)
const createPost = async (req, res) => {
  try {
    const { truckType, bsVersion, driverType, timeDuration, location } = req.body;
    
    // Check for required fields except photos
    if (!truckType || !bsVersion || !driverType || !timeDuration || !location) {
      return res.status(400).json({ error: 'Please provide all the required fields' });
    }

    // Get photos from the request files if they exist
    const photos = req.files ? req.files.map(file => file.path) : [];

    // Create a new post with default values for potentially missing fields
    const newPost = new Post({
      truckType: truckType || '',
      bsVersion: bsVersion || '',
      driverType: driverType || '',
      timeDuration: timeDuration || '',
      location: location || '',
      photos: photos,
      owner: req.user._id,
    });

    // Save the post
    await newPost.save();

    console.log('Created post:', newPost); // Debug log
    res.status(201).json({ message: 'Post created successfully', post: newPost });
  } catch (error) {
    console.error('Error creating post:', error);
    res.status(500).json({ error: 'Server error' });
>>>>>>> f7ca15abc46e4a9a01a98af93c6a6a34d550af36
  }
};

module.exports = { createPost };
