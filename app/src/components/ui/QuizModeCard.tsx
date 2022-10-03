import React from 'react';
import LightGreyCard from "./LightGreyCard";
import Button from "@mui/material/Button";
import ValveGroup from "./ValveGroup";
import styles from "./QuizModeCard.module.css"
import {useSelector} from "react-redux";
import {RootState} from "../../features/store";
import {Pitch} from "../../models/Pitch";
import {Pitches} from "../../models/Pitches";
import QuizSlice, {submitWrongAnswer} from "../../features/quizData/quizSlice";
import {convertPitchInstrumentIdToImageId} from "./convertPitchInstrumentIdToImageId";
import {useAppDispatch} from "../../features/hooks";
import {useCreateQuizPitchAttemptMutation} from "../../features/quizData/quiz-api";



const QuizModeCard = () => {
    // const pitches = useSelector<RootState, Pitch>((state) => state.quizAttemptSlice.extendedPitches);
    const currentPitchIndex = useSelector<RootState, number>((state) => state.quizAttemptSlice.currentPitchIndex);
    // @ts-ignore
    const quizAttemptSlice = useSelector<RootState, QuizSlice>((state) => state.quizAttemptSlice);
    const dispatch = useAppDispatch();
    const [createQuizPitchAttemptMutation, {data, isLoading, isError}] = useCreateQuizPitchAttemptMutation();

    console.log(quizAttemptSlice.extendedPitches[currentPitchIndex][0]["position"]);

    console.log(quizAttemptSlice.extendedPitches[0][0]["id"]);
    const pitchId = quizAttemptSlice.extendedPitches[0][0]["id"];
    const imageId = convertPitchInstrumentIdToImageId(pitchId);
    const imageUrl = `https://valvio-data-bucket.s3.us-east-2.amazonaws.com/valvio_pitches/${imageId}_treble.png`;

    const handleSubmitButton = () => {
        console.log("You're probably wrong but ok!");
        dispatch(submitWrongAnswer());

        //TODO: Make sure that the data for transpositions is getting included
        //Todo: this is not real data:

        const body = {
            isCorrect: true,
            userInput: 0,
            quizPitchId: 10,
            quizAttemptId: 300,
        };
        createQuizPitchAttemptMutation({userId: 7, body});
    }

    return (
        <LightGreyCard>
            <>
                <img className = {styles["pitch-img"]} src={imageUrl} alt="pitch"/>
                <ValveGroup/>
                <Button
                    onClick ={handleSubmitButton}
                    variant="contained" size ="large" sx={{
                    width: '70%',
                }} >Submit</Button>
            </>
        </LightGreyCard>
    );
};

export default QuizModeCard;

// "https://valvio-data-bucket.s3.us-east-2.amazonaws.com/valvio_pitches/cna5_treble.png"