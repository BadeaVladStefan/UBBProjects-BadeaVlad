import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import LoginForm from './LoginForm';
import RegisterForm from './RegisterForm';
import MainApp from './MainApp';

const App = () => {
  return (
    <Router>
      <Routes>
        <Route path="/login" element={<LoginForm />} />
        <Route path="/register" element={<RegisterForm />} />
        <Route path="/app" element={<MainApp />} />
        <Route path="/" element={<LoginForm />} /> // Default route
      </Routes>
    </Router>
  );
};

export default App;