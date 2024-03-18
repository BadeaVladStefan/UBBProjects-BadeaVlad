import React, { useState } from 'react';
import './UpdateF1DriverForm.css';

interface UpdateF1DriverFormProps {
    onUpdate: (name: string, team: string, age: number) => void;
}

function UpdateF1DriverForm({ onUpdate }: UpdateF1DriverFormProps) {
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
        onUpdate(name, team, ageValue);
        setName('');
        setTeam('');
        setAge('');
    };

    return (
        <div className="update-f1-driver-container">
            <header>
                <h1 className="title">Update F1 Driver</h1>
            </header>
            <form onSubmit={handleSubmit}>
                <div className="form-group">
                    <label className="form-label">Name:</label>
                    <input className="form-field" type="text" value={name} onChange={(e) => setName(e.target.value)} />
                </div>
                <div className="form-group">
                    <label className="form-label">New Team:</label>
                    <input className="form-field" type="text" value={team} onChange={(e) => setTeam(e.target.value)} />
                </div>
                <div className="form-group">
                    <label className="form-label">New Age:</label>
                    <input className="form-field" type="number" value={age} onChange={(e) => setAge(e.target.value)} />
                </div>
                <button className='button' type="submit">Update Driver</button>
            </form>
        </div>
    );
}

export default UpdateF1DriverForm;
