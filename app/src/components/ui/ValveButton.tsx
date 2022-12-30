import React, {useCallback, useEffect, useRef, useState} from 'react';
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

    const handler = useCallback((event: KeyboardEvent)=>{
        if (event.key === props.keyBoardKey) {
            setIsPressed((isPressed) => {
                props.onValveChange(!isPressed);
                return !isPressed;
            });
        }
    }, [])

    useEffect(() => {
        window.addEventListener('keyup', handler, true);

        return ()=>{
            window.removeEventListener('keyup', handler, true);
        }
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
