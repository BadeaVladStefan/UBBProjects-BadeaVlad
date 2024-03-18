import React, { useState } from 'react';
import { F1Driver } from '../models/F1Drivers';
import './AddF1DriverForm.css';

interface AddF1DriverFormProps {
    onAdd: (driver: F1Driver) => void;
}

function AddF1DriverForm({ onAdd }: AddF1DriverFormProps) {
    const [name, setName] = useState('');
    const [team, setTeam] = useState('');
    const [age, setAge] = useState('');

    const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        if (!name || !team || !age) {
            alert('Please fill in all fields');
            return;
        }
        const ageValue = parseInt(age);
        if (isNaN(ageValue) || ageValue <= 0) {
            alert('Please enter a valid age');
            return;
        }
        const newDriver = new F1Driver(0, name, team, ageValue, true);
        onAdd(newDriver); 
        setName('');
        setTeam('');
        setAge('');
    };

    return (
        <div className="add-f1-driver-container">
            <header>
                <h1 className="title">Add F1 Driver</h1>
            </header>
            <form onSubmit={handleSubmit}>
                <div className="form-group">
                    <label className="form-label">Name:</label>
                    <input className="form-field" type="text" value={name} onChange={(e) => setName(e.target.value)} />
                </div>
                <div className="form-group">
                    <label className="form-label">Team:</label>
                    <input className="form-field" type="text" value={team} onChange={(e) => setTeam(e.target.value)} />
                </div>
                <div className="form-group">
                    <label className="form-label">Age:</label>
                    <input className="form-field" type="number" value={age} onChange={(e) => setAge(e.target.value)} />
                </div>
                <button className='button' type="submit">Add Driver</button>
            </form>
        </div>
    );
}

export default AddF1DriverForm;
