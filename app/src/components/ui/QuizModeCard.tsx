import React, {useCallback, useEffect, useState} from 'react';
import LightGreyCard from "./LightGreyCard";
import Button from "@mui/material/Button";
import TrumpetValveGroup from "./TrumpetValveGroup";
import styles from "./QuizModeCard.module.css"
import {useSelector} from "react-redux";
import {RootState} from "../../features/store";
import {Pitch} from "../../models/Pitch";
import {PitchesObject} from "../../models/PitchesObject";
import QuizSlice, {endCompletedQuiz, submitCorrectAnswer, submitWrongAnswer} from "../../features/quizData/quizSlice";
import {useAppDispatch} from "../../features/hooks";
import {useCreateQuizPitchAttemptMutation} from "../../features/quizData/quiz-api";
import {useNavigate} from "react-router-dom";
import {createImageUrlFromPitchId} from "../../helper/createImageUrlFromPitchId";
import {TrumpetValves} from "../../models/TrumpetValves";
import {QuizPitchAttemptDto} from "../../models/QuizPitchAttemptDto";


const QuizModeCard = () => {
    const navigate = useNavigate();
    const dispatch = useAppDispatch();
    const [userInput, setUserInput] = useState("0");
    const [resetValves, setResetValves] = useState(false);
    const authSlice = useSelector((state: RootState) => state.authSlice);

    const currentPitchIndex = useSelector<RootState, number>((state) => state.quizAttemptSlice.currentPitchIndex);
    const pitchesObject = useSelector<RootState, PitchesObject[]>((state) => state.quizAttemptSlice.extendedPitches);
    const quizAttemptId = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.quizAttemptId);

    if (!pitchesObject[currentPitchIndex]){
        return <h1>There was an error starting your quiz. Go back to the homepage and try again.</h1>
    }

    const currentPitchObject: Pitch = pitchesObject[currentPitchIndex]['originalPitch'];
    const currentTranspositionPitchObject: Pitch | null = pitchesObject[currentPitchIndex]['transposedAnswer'];
    const currentPitchAnswer = currentTranspositionPitchObject ? currentTranspositionPitchObject.position : pitchesObject[currentPitchIndex].originalPitch.position;

    // const handler = useCallback((event: KeyboardEvent)=>{
    //     if (event.key === "a"){
    //         console.log("User input after submitting with A Key" , userInput);
    //         console.log(currentPitchIndex);
    //         handleSubmitButton()
    //     }
    // }, [userInput]);
    //
    //
    // useEffect(() => {
    //     console.log("eventListener for a submit key");
    //     window.addEventListener('keydown', (event) => {
    //         handler(event);
    //     });
    //
    //     return () => {
    //         window.removeEventListener('keydown', handler);
    //     }
    // }, [handler]);

    const handleUserInputChange = (newInput: string) =>{
        setUserInput(newInput);
    }

    const handleSubmitButton = () => {
        let isUserCorrect = (currentPitchAnswer == userInput);


        //For each question, start appending the data onto a body object
        // const body = {
        //     isCorrect: isUserCorrect,
        //     userInput: userInput,
        //     quizPitchId: pitchesObject[currentPitchIndex].quizPitchId,
        //     quizAttemptId: quizAttemptId,
        // };
        // createQuizPitchAttemptMutation({userId: authSlice.uid, body});


        const quizPitchAttempt: QuizPitchAttemptDto = {
            isCorrect: isUserCorrect,
            userInput: userInput,
            quizPitchId: pitchesObject[currentPitchIndex].quizPitchId,
            quizAttemptId: quizAttemptId,
        }

        setResetValves(true);

        if (isUserCorrect){
            dispatch(submitCorrectAnswer(quizPitchAttempt));

            if (currentPitchIndex+1 >= pitchesObject.length) {
                dispatch(endCompletedQuiz());
                navigate('/completed-quiz-summary');
            }
        } else {
            dispatch(submitWrongAnswer(quizPitchAttempt));
        }

    }

    const handleValvesWereReset=()=>{
        setUserInput("0");
        setResetValves(false);
    }

    return (
        <LightGreyCard >
            <div >
                <img className = {styles["pitch-img"]} style={{maxHeight : '200px'}} src={createImageUrlFromPitchId(currentPitchObject.id)} alt="pitch"/>
                <TrumpetValveGroup onValvesWereReset = {handleValvesWereReset} resetValves = {resetValves} onUserInputChange={(newInput:string)=>handleUserInputChange(newInput)} />
                <Button
                    onClick ={handleSubmitButton}
                    variant="contained" size ="large" sx={{
                    width: '70%',
                }} >
                    Submit
                </Button>
            </div>
        </LightGreyCard>
    );
};

export default QuizModeCard;

// "https://valvio-data-bucket.s3.us-east-2.amazonaws.com/valvio_pitches/cna5_treble.png"