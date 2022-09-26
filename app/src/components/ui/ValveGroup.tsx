import React from 'react';
import ValveButton from "./ValveButton";
import styles from './ValveGroup.module.css';

const ValveGroup = () => {
    return (
        <div className = {styles["valve-container"]}>
            <ValveButton/>
            <ValveButton/>
            <ValveButton/>
        </div>
    );
};

export default ValveGroup;