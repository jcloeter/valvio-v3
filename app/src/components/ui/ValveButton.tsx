import React, { useEffect, useRef, useState } from 'react';
import styles from './ValveButton.module.css';

const ValveButton: React.FC<{
    resetValve: boolean;
    valveNumber: string;
    keyBoardKey: string;
    onValveChange: (isPressed: boolean) => void;
}> = (props: {
    resetValve: boolean;
    valveNumber: string;
    keyBoardKey: string;
    onValveChange: (isPressed: boolean) => void;
}) => {
    const [isPressed, setIsPressed] = useState(false);

    useEffect(() => {
        console.log('ValveButton UseEffect');
        window.addEventListener('keydown', (event) => {
            if (event.key === props.keyBoardKey) {
                setIsPressed((isPressed) => {
                    props.onValveChange(!isPressed);
                    return !isPressed;
                });
            }

            //Possible solution for "a" key
            // if (event.key === "a"){
            //     props.onValveSubmit();
            // }
        });
    }, []);

    useEffect(() => {
        setIsPressed(false);
    }, [props.resetValve]);

    const handleValvePress = () => {
        setIsPressed((isPressed) => {
            props.onValveChange(!isPressed);
            return !isPressed;
        });
    };

    return (
        <div>
            <input type="checkbox" className={styles['btn-valve']} onChange={handleValvePress} checked={isPressed} />
        </div>
    );
};

export default ValveButton;
