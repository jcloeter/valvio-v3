import React, {useState} from 'react';
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


const QuizModeCard = () => {
    const navigate = useNavigate();
    const dispatch = useAppDispatch();
    const [userInput, setUserInput] = useState("0");

    const [createQuizPitchAttemptMutation, {data, isLoading, isError}] = useCreateQuizPitchAttemptMutation();

    const currentPitchIndex = useSelector<RootState, number>((state) => state.quizAttemptSlice.currentPitchIndex);
    const pitchesObject = useSelector<RootState, PitchesObject[]>((state) => state.quizAttemptSlice.extendedPitches);
    const currentPitchObject: Pitch = pitchesObject[currentPitchIndex]['originalPitch'];
    const currentTranspositionPitchObject: Pitch | null = pitchesObject[currentPitchIndex]['transposedAnswer'];
    const currentPitchAnswer = currentTranspositionPitchObject ? currentTranspositionPitchObject.position : pitchesObject[currentPitchIndex].originalPitch.position;
    const quizAttemptId = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.quizAttemptId);

    const handleUserInputChange = (newInput: string) =>{
        setUserInput(newInput);
    }

    const handleSubmitButton = () => {
        let isUserCorrect = (currentPitchAnswer == userInput);
        console.log(currentPitchObject);
        console.log(pitchesObject);

        const body = {
            isCorrect: isUserCorrect,
            userInput: userInput,
            quizPitchId: pitchesObject[currentPitchIndex].quizPitchId,
            quizAttemptId: quizAttemptId,
        };
        createQuizPitchAttemptMutation({userId: 7, body});

        console.log(body);


        if (isUserCorrect){
            dispatch(submitCorrectAnswer());

            if (currentPitchIndex+1 >= pitchesObject.length) {
                dispatch(endCompletedQuiz());
                navigate('/completed-quiz-summary');
            }
        } else {
            dispatch(submitWrongAnswer());
        }

    }

    //Todo: Reset valves after each attempt

    return (
        <LightGreyCard>
            <>
                <img className = {styles["pitch-img"]} src={createImageUrlFromPitchId(currentPitchObject.id)} alt="pitch"/>
                <TrumpetValveGroup onUserInputChange={(newInput:string)=>handleUserInputChange(newInput)} />
                <Button
                    onClick ={handleSubmitButton}
                    variant="contained" size ="large" sx={{
                    width: '70%',
                }} >
                    Submit
                </Button>
            </>
        </LightGreyCard>
    );
};

export default QuizModeCard;

// "https://valvio-data-bucket.s3.us-east-2.amazonaws.com/valvio_pitches/cna5_treble.png"