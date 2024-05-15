import express from 'express';
import mongoose from 'mongoose';
import f1DriverRoutes from './routes/f1DriverRoutes';
import http from 'http';

const app = express();

// Connect to MongoDB
const mongoURI = process.env.MONGODB_URI;

if (!mongoURI) {
  throw new Error('MongoDB URI is not defined in the environment variables.');
}

mongoose.connect(mongoURI)
.then(() => {
  console.log('Connected to MongoDB');
})
.catch((error) => {
  console.error('Error connecting to MongoDB:', error);
});

// Middleware
app.use(express.json());

// CORS headers
app.use((_req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    next();
});

// Login route
app.get('/login', (_, res) => {
    res.send('Login page'); // Response for the login page
});

// Routes
app.use('/api', f1DriverRoutes);

const PORT = process.env.PORT || 5000;
const server = http.createServer(app);
server.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
