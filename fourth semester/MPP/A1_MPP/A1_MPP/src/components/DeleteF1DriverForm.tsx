import React, { useState } from 'react';
import './DeleteF1DriverForm.css';

interface DeleteF1DriverFormProps {
    onDelete: (name: string) => void;
}

function DeleteF1DriverForm({ onDelete }: DeleteF1DriverFormProps) {
    const [name, setName] = useState('');

    const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        if (!name) {
            alert('Please fill in the name field');
            return;
        }
        onDelete(name); 
        setName('');
    };

    return (
        <div className="delete-f1-driver-container">
            <header>
                <h1 className="title">Delete F1 Driver</h1>
            </header>
            <form onSubmit={handleSubmit}>
                <div className="form-group">
                    <label className="form-label">Name:</label>
                    <input className="form-field" type="text" value={name} onChange={(e) => setName(e.target.value)} />
                </div>
                <button className='button' type="submit">Delete Driver</button>
            </form>
        </div>
    );
}

export default DeleteF1DriverForm;
