import React, {useEffect, useState} from 'react';
import {useParams} from "react-router";
import {useNavigate} from "react-router-dom";
import {useCreateQuizAttemptMutation, useGetPitchesByQuizIdQuery} from "../features/quizData/quiz-api";
import {Box, CircularProgress, Fab} from "@mui/material";
import CheckCircleOutlineIcon from '@mui/icons-material/CheckCircleOutline';
import {useAppDispatch} from "../features/hooks";
import {setStartTime} from "../features/quizData/quizSlice";
import {useSelector} from "react-redux";
import {RootState} from "../features/store";


type QuizModeParams = {
    quizId: string
}

const QuizLoadingPage = () => {
    let {quizId} = useParams();
    const dispatch = useAppDispatch();
    const navigate = useNavigate();
    const [timer, setTimer] = useState(5);
    const [showTimer, setShowTimer] = useState(false);
    let interval: any;

    const authSlice = useSelector((state: RootState) => state.authSlice);

    // @ts-ignore
    const {data: pitches, refetch: refetchQuizPitches, isLoading: arePitchesLoading, isError: arePitchesError} = useGetPitchesByQuizIdQuery(quizId);
    const [ createQuizAttemptMutation,{data, isLoading: isCreateQALoading, isError: isCreateQAError}] = useCreateQuizAttemptMutation();

    useEffect(()=>{
        refetchQuizPitches();
        const result = createQuizAttemptMutation({userId: authSlice.uid, quizId: quizId}).unwrap().then(fulfilled => console.log(fulfilled)).catch(rejected => console.error(rejected));
    }, [createQuizAttemptMutation, quizId, refetchQuizPitches])

    useEffect(()=>{
        if (arePitchesLoading || arePitchesError) {
            return;
        }

        if (isCreateQALoading || isCreateQAError) {
            return;
        }

        interval = setInterval(decreaseTimerAndRedirect, 1000);
        setShowTimer(true);

        return () => clearInterval(interval);
    }, [arePitchesLoading, arePitchesError, isCreateQAError, isCreateQALoading]);

    useEffect(()=>{
        if (timer === 0 && pitches) {
            dispatch(setStartTime());
            clearInterval(interval);
            navigate(`/quiz/${quizId}`);
        }
    }, [timer])


    const decreaseTimerAndRedirect=()=>{
        setTimer((count: number)=>{
            count = count -1;
            return count;
        })
    }

    return (
        <div>
            <Box sx={{ m: 1, position: 'relative' }}>
                {arePitchesLoading ? (
                    <CircularProgress
                        size={18}
                        sx={{
                            color: "green",
                            position: 'absolute',
                            top: -6,
                            left: -6,
                            zIndex: 1,

                        }}
                    />
                ): <CheckCircleOutlineIcon sx={{color: "green"}}/>}
                <h3>Loading Pitches</h3>
            </Box>

            <Box sx={{ m: 1, position: 'relative' }}>
                {isCreateQALoading ? (
                    <CircularProgress
                        size={18}
                        sx={{
                            color: "green",
                            position: 'absolute',
                            top: -6,
                            left: -6,
                            zIndex: 1,
                        }}
                    />
                ): <CheckCircleOutlineIcon sx={{color: "green"}}/>}
                <h3>Initializing QuizData</h3>
            </Box>
            {showTimer && (<div>Quiz Starting in <b>{timer}</b></div>)}
        </div>
    );
};

export default QuizLoadingPage;


