import React from 'react';
import { F1Driver } from '../models/F1Drivers';

interface F1DriverListProps {
    drivers: F1Driver[];
}

const F1DriverList: React.FC<F1DriverListProps> = ({ drivers }) => {
    return (
        <div className="f1-driver-list-container">
            <h2 className="list-title">F1 Drivers</h2>
            <ul className="driver-list">
                {drivers.map(driver => (
                    <li key={driver.id} className="driver-item">
                        <span className='driver-data'>{driver.toString()}</span>
                    </li>
                ))}
            </ul>
        </div>
    );
}

export default F1DriverList;
