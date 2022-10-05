import React, {useEffect, useRef, useState} from 'react';
import styles from './ValveButton.module.css';

const ValveButton: React.FC<{ valveNumber: string; keyBoardKey: string; onValveChange: (isPressed: boolean) => void }> = (props:{valveNumber: string, keyBoardKey: string, onValveChange: (isPressed: boolean)=>void}) => {
    const [isPressed, setIsPressed] = useState(false);

    useEffect(() => {
        window.addEventListener('keydown', (event) => {
            if (event.key === props.keyBoardKey){
                console.log("Pressing down " + props.valveNumber);
                setIsPressed((isPressed) => {
                    props.onValveChange(!isPressed);
                    return !isPressed;
                });
            }
        });
    }, []);

    //Start here: Must fix bugs in the valve up/down logic

    const handleValvePress = () => {
        setIsPressed((isPressed) => {
            props.onValveChange(!isPressed);
            return !isPressed;
        });
    }

    return (
        <div>
            <input type="checkbox"
                   className = {styles["btn-valve"]}
                   onChange={handleValvePress}
                   checked={isPressed}
            />
        </div>
    );
};

export default ValveButton;