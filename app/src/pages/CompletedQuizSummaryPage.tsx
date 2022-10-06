import React, {useEffect} from 'react';
import {useAppDispatch, useAppSelector} from "../features/hooks";
import {endCompletedQuiz, resetQuizData} from "../features/quizData/quizSlice";
import {usePatchQuizAttemptMutation} from "../features/quizData/quiz-api";
import {useSelector} from "react-redux";
import {RootState} from "../features/store";
import Button from "@mui/material/Button";
import {useNavigate} from 'react-router-dom';
import GradingIcon from "@mui/icons-material/Grading";
import MusicNoteIcon from "@mui/icons-material/MusicNote";
import AvTimerIcon from "@mui/icons-material/AvTimer";
import {LinearProgress} from "@mui/material";


const CompletedQuizSummaryPage = () => {
    const dispatch = useAppDispatch();
    const navigate = useNavigate();
    const [patchQuizAttemptMutation, {data, isError, isLoading}] = usePatchQuizAttemptMutation();

    const quizAttemptId = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.quizAttemptId);
    const startTime = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.startTime);
    const endTime = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.endTime);
    const quizSlice = useAppSelector(state => state.quizAttemptSlice);
    const currentPitchIndex = useSelector<RootState, number>((state) => state.quizAttemptSlice.currentPitchIndex);


    let completedIn: number | null;
    if (startTime && endTime) {
        completedIn = (endTime - startTime) / 1000;
    }

    useEffect(()=>{
        patchQuizAttemptMutation({
            userId: 7,
            quizAttemptId,
            completedIn
        });
    }, [])

    const navigateHome = () => {
        navigate('/');
    }

    let loadingContent;
    let errorContent;
    if (isLoading) {
         loadingContent = "Sending Score to server- Don't leave this page just yet";
    }
    if (isError) {
        errorContent = "There was a mistake sending your quiz information to the server. Check your internet connection and try again."
    }

    let speed: string | number = "n/a";
    if (currentPitchIndex >0 && quizSlice.startTime) {
        speed = ((Date.now() - quizSlice.startTime)/(currentPitchIndex*1000)).toFixed(2)+'s/pitch';
    }

    return (
        <div>
            <h1>Congrats on Finishing</h1>

            <div>
                <GradingIcon sx={{color : "gray"}}/> {quizSlice.currentScore.toFixed(0)}%
            </div>
            <div>
                <MusicNoteIcon sx={{color : "gray"}}/> Wrong Answers: {quizSlice.incorrectPitchAttempts}/{quizSlice.quizLength}
            </div>
            <div>
                <AvTimerIcon sx={{color : "gray"}}/> {speed}
            </div>
            {loadingContent}
            {errorContent}
            {isLoading && <LinearProgress sx={{maxWidth: '80%'}}/>}
            {!isLoading && <Button variant="contained" onClick = {navigateHome}>Back to Home</Button>}
        </div>
    );
};

//useLocalStorage???
export default CompletedQuizSummaryPage;