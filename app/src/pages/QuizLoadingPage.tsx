import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router';
import { useNavigate } from 'react-router-dom';
import {
    useCreateQuizAttemptMutation,
    useGetPitchesByQuizIdQuery,
    useGetQuizzesQuery,
} from '../features/quizData/quiz-api';
import { Box, CircularProgress, Fab } from '@mui/material';
import CheckCircleOutlineIcon from '@mui/icons-material/CheckCircleOutline';
import { useAppDispatch } from '../features/hooks';
import { resetQuizData, setStartTime } from '../features/quizData/quizSlice';
import { useSelector } from 'react-redux';
import { RootState } from '../features/store';
import IconAndTextWrapper from './IconAndTextWrapper';
import {Quiz} from "../models/Quiz";

type QuizModeParams = {
    quizId: string;
};

const QuizLoadingPage = () => {
    const { quizId } = useParams();
    const dispatch = useAppDispatch();
    const navigate = useNavigate();
    const [timer, setTimer] = useState(3);
    const [showTimer, setShowTimer] = useState(false);
    let interval: any;

    const authSlice = useSelector((state: RootState) => state.authSlice);
    const {data: quizzes, isLoading: areQuizzesLoading, isError: areQuizzesError} = useGetQuizzesQuery(quizId);
    const [currentQuiz, setCurrentQuiz] = useState<Quiz|undefined>();

    const {
        data: pitches,
        refetch: refetchQuizPitches,
        isLoading: arePitchesLoading,
        isError: arePitchesError,
        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-ignore
    } = useGetPitchesByQuizIdQuery(quizId);
    const [createQuizAttemptMutation, { data, isLoading: isCreateQALoading, isError: isCreateQAError }] =
        useCreateQuizAttemptMutation();

    useEffect(() => {
        dispatch(resetQuizData());
    }, []);

    useEffect(() => {
        refetchQuizPitches();
        const result = createQuizAttemptMutation({ userId: authSlice.uid, quizId: quizId })
            .unwrap()
            .then()
            .catch();
    }, [createQuizAttemptMutation, quizId, refetchQuizPitches]);

    useEffect(() => {
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

    useEffect(() => {
        if (timer === 0 && pitches) {
            dispatch(setStartTime());
            clearInterval(interval);
            navigate(`/quiz/${quizId}`);
        }
    }, [timer]);

    let quiz: Quiz | undefined;

    useEffect(()=>{
        if (quizzes?.quizzes){
            quiz = quizzes.quizzes.filter((q: Quiz)=>q.id.toString() == quizId)[0];
            setCurrentQuiz(quiz);
        }

    }, [quizzes, areQuizzesLoading])

    const decreaseTimerAndRedirect = () => {
        setTimer((count: number) => {
            count = count - 1;
            return count;
        });
    };

    return (
        <div>
            {currentQuiz &&
                <div>
                    <h3>Level {currentQuiz.level}. {currentQuiz.name}</h3>
                </div>

            }
            <Box sx={{ m: 1, position: 'relative' }}>
                <IconAndTextWrapper>
                    <>
                        {arePitchesLoading ? (
                            <CircularProgress size={18} sx={{ color: 'green' }} />
                        ) : (
                            <CheckCircleOutlineIcon sx={{ color: 'green' }} />
                        )}
                        <h3>Loading Pitches</h3>
                    </>
                </IconAndTextWrapper>
            </Box>

            <Box sx={{ m: 1, position: 'relative' }}>
                <IconAndTextWrapper>
                    <>
                        {isCreateQALoading ? (
                            <CircularProgress
                                size={18}
                                sx={{
                                    color: 'green',
                                }}
                            />
                        ) : (
                            <CheckCircleOutlineIcon sx={{ color: 'green' }} />
                        )}
                        <h3>Initializing QuizData</h3>
                    </>
                </IconAndTextWrapper>
            </Box>
            {showTimer && (
                <div>
                    Quiz Starting in <b>{timer}</b>
                </div>
            )}
        </div>
    );
};

export default QuizLoadingPage;
