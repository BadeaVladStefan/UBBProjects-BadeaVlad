import express from 'express';
import mongoose from 'mongoose';
import f1DriverRoutes from './routes/f1DriverRoutes';

const app = express();

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/MPP')
    .then(() => console.log('Connected to MongoDB'))
    .catch(err => console.error('Error connecting to MongoDB', err));


// Middleware
app.use(express.json());

// CORS headers
app.use((_req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    next();
});

// Routes
app.use('/api', f1DriverRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
