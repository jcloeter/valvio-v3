import React, {KeyboardEventHandler, useEffect, useState} from 'react';
import ValveButton from "./ValveButton";
import styles from './ValveGroup.module.css';
import {TrumpetValves} from "../../models/TrumpetValves";


const TrumpetValveGroup: React.FC<{onUserInputChange: (newInput: string)=>void, onValvesWereReset: ()=> void, resetValves: boolean}> = (props) => {
    const [valveState, setValveState] = useState<TrumpetValves>({
        valve1 : false,
        valve2 : false,
        valve3 : false,
        answer: "0",
    });

    const handleValveChange=(isPressed: boolean, valveNumber: number)=>{
        setValveState((valveState)=>{
            let valve1IsPressed = valveState.valve1;
            let valve2IsPressed = valveState.valve2;
            let valve3IsPressed = valveState.valve3;

            if (valveNumber === 1) valve1IsPressed = isPressed;
            if (valveNumber === 2) valve2IsPressed = isPressed;
            if (valveNumber === 3) valve3IsPressed = isPressed;

            let answer: string | null = (valve1IsPressed ? '1' : '') + (valve2IsPressed ? '2' : '') + (valve3IsPressed ? '3' : '');
            if (!answer) {
                answer = "0";
            }

            props.onUserInputChange(answer);

            return {
                valve1: valve1IsPressed,
                valve2: valve2IsPressed,
                valve3: valve3IsPressed,
                answer: answer,
            }
        });
    };

    useEffect(()=>{
        if (props.resetValves){
            setValveState({
                valve1 : false,
                valve2 : false,
                valve3 : false,
                answer: "0",
            });
        }

        props.onValvesWereReset();
    }, [props.resetValves])

    return (
        <div className = {styles["valve-container"]} >
            <ValveButton resetValve = {props.resetValves} valveNumber = {'1'} keyBoardKey = {'7'} onValveChange = {(isPressed)=>handleValveChange(isPressed, 1)} />
            <ValveButton resetValve = {props.resetValves} valveNumber = {'2'} keyBoardKey = {'8'} onValveChange = {(isPressed)=>handleValveChange(isPressed, 2)} />
            <ValveButton resetValve = {props.resetValves} valveNumber = {'3'} keyBoardKey = {'9'} onValveChange = {(isPressed)=>handleValveChange(isPressed, 3)} />
        </div>
    );
};

export default TrumpetValveGroup;