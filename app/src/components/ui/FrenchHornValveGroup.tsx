import React from 'react';
import ValveButton from "./ValveButton";
import styles from "./ValveGroup.module.css";

const FrenchHornValveGroup : React.FC<{
    onUserInputChange: (newInput: string) => void;
    onValvesWereReset: () => void;
    resetValves: boolean;
}> = (props) => {
    return (
        <div  className={styles['valve-container']}>
            {/*<ValveButton*/}
            {/*    resetValve={props.resetValves}*/}
            {/*    valveNumber={'1'}*/}
            {/*    keyBoardKey={'f'}*/}
            {/*    onValveChange={(isPressed) => handleValveChange(isPressed, 1)}*/}
            {/*/>*/}
        </div>
    );
};

export default FrenchHornValveGroup;