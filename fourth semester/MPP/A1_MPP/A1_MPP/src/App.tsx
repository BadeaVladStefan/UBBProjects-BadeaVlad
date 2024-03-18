import { useState } from 'react';
import './App.css';
import AddF1DriverForm from './components/AddF1DriverForm';
import DeleteF1DriverForm from './components/DeleteF1DriverForm';
import UpdateF1DriverForm from './components/UpdateF1DriverForm';
import F1DriverList from './components/ShowF1DriverList';
import { Repository } from './features/Repository';
import { F1Driver } from './models/F1Drivers';

const repository = new Repository();

function App() {
    const [drivers, setDrivers] = useState<F1Driver[]>(repository.displayAllDrivers());

    const handleAddDriver = (driver: F1Driver) => {
        repository.addF1Driver(driver);
        setDrivers(repository.displayAllDrivers());
    };

    const handleDeleteDriver = (name: string) => {
        repository.deleteF1DriverByName(name);
        setDrivers(repository.displayAllDrivers());
    };

    const handleUpdateDriver = (name: string, team: string, age: number) => {
        repository.updateF1DriverByName(name, new F1Driver(0, name, team, age, true));
        setDrivers(repository.displayAllDrivers());
    };

    return (
        <div className="App">
            <header className="App-header">
                <h1>F1 Driver Management</h1>
                <div className="row">
                    <div className="column">
                        <F1DriverList drivers={drivers} />
                    </div>
                    <div className="column">
                        <AddF1DriverForm onAdd={handleAddDriver} />
                    </div>
                </div>
                <div className="row">
                    <div className="column">
                        <DeleteF1DriverForm onDelete={handleDeleteDriver} />
                    </div>
                    <div className="column">
                        <UpdateF1DriverForm onUpdate={handleUpdateDriver} />
                    </div>
                </div>
            </header>
        </div>
    );
}

export default App;
