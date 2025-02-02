const { OwnerPost } = require('../models/postModel');

// Create a post (for owners)
const createPost = async (req, res) => {
  try {
    const { truckType, bsVersion, driverType, timeDuration, location } = req.body;
    
    if (!truckType || !bsVersion || !driverType || !timeDuration || !location) {
      return res.status(400).json({ error: 'Please provide all required fields' });
    }

    const photos = req.files ? req.files.map(file => file.path) : [];

    const newPost = new OwnerPost({
      truckType,
      bsVersion,
      driverType,
      timeDuration,
      location,
      photos,
      owner: req.user.userId,
      userType: 'owner'
    });

    await newPost.save();
    console.log('Created owner post:', newPost);
    res.status(201).json({ message: 'Post created successfully', post: newPost });
  } catch (error) {
    console.error('Error creating post:', error);
    res.status(500).json({ error: 'Server error' });
  }
};

// Get posts for logged-in owner
const getMyPosts = async (req, res) => {
  try {
    const posts = await OwnerPost.find({ owner: req.user.userId })
      .sort({ createdAt: -1 });
    
    console.log('Fetched owner posts:', posts);
    res.status(200).json(posts);
  } catch (error) {
    console.error('Error fetching posts:', error);
    res.status(500).json({ error: 'Server error' });
  }
};

module.exports = { createPost, getMyPosts };
