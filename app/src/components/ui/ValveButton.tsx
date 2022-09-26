import React from 'react';
import styles from './ValveButton.module.css';

const ValveButton = () => {
    return (
        <div>
            <input type="checkbox" className = {styles["btn-valve"]}/>
        </div>
    );
};

export default ValveButton;