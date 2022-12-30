import React, { useEffect } from 'react';
import { useAppDispatch, useAppSelector } from '../features/hooks';
import { endCompletedQuiz, resetQuizData } from '../features/quizData/quizSlice';
import { useCreateQuizPitchAttemptMutation, usePatchQuizAttemptMutation } from '../features/quizData/quiz-api';
import { useSelector } from 'react-redux';
import { RootState } from '../features/store';
import Button from '@mui/material/Button';
import {Link, useNavigate} from 'react-router-dom';
import GradingIcon from '@mui/icons-material/Grading';
import MusicNoteIcon from '@mui/icons-material/MusicNote';
import AvTimerIcon from '@mui/icons-material/AvTimer';
import { LinearProgress } from '@mui/material';
import { QuizPitchAttemptDto } from '../models/QuizPitchAttemptDto';
import IconAndTextWrapper from './IconAndTextWrapper';
import MetricIcons from '../components/ui/MetricIcons';

const CompletedQuizSummaryPage = () => {
    const dispatch = useAppDispatch();
    const navigate = useNavigate();

    const [
        createQuizPitchAttemptMutation,
        { data: createQuizPitchAttemptData, isLoading: quizPitchAttemptIsLoading, isError: quizPitchAttemptIsError },
    ] = useCreateQuizPitchAttemptMutation();
    const [patchQuizAttemptMutation, { data, isError, isLoading }] = usePatchQuizAttemptMutation();

    const quizAttemptId = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.quizAttemptId);
    const startTime = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.startTime);
    const endTime = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.endTime);
    const quizPitchAttemptArr = useSelector<RootState, QuizPitchAttemptDto[]>(
        (state) => state.quizAttemptSlice.quizPitchAttempts,
    );
    const quizSlice = useAppSelector((state) => state.quizAttemptSlice);
    const currentPitchIndex = useSelector<RootState, number>((state) => state.quizAttemptSlice.currentPitchIndex);
    const authSlice = useSelector((state: RootState) => state.authSlice);

    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    const completedIn: number | null = (endTime - startTime) / 1000;

    useEffect(() => {
        createQuizPitchAttemptMutation({ userId: authSlice.uid, body: quizPitchAttemptArr });
    }, []);

    useEffect(() => {
        if (createQuizPitchAttemptData && !quizPitchAttemptIsError && !quizPitchAttemptIsLoading) {
            patchQuizAttemptMutation({
                userId: authSlice.uid,
                quizAttemptId,
                completedIn,
            });
        }
    }, [createQuizPitchAttemptData, quizPitchAttemptIsError, quizPitchAttemptIsLoading]);

    const navigateHome = () => {
        navigate(`/#${quizSlice.quizId}`);
    };

    let loadingContent;
    let errorContent;
    if (isLoading || quizPitchAttemptIsLoading) {
        loadingContent = "Sending Score to server- Don't leave this page just yet";
    }
    if (isError) {
        errorContent =
            'There was a mistake sending your quiz information to the server. Check your internet connection and try again.';
    }

    let speed: string | number = 'n/a';
    speed = (completedIn / (currentPitchIndex + 1)).toFixed(2) + 's/pitch';

    return (
        <div>
            <h1>Congrats on Finishing</h1>
            <br />
            <div>
                <IconAndTextWrapper>
                    <>
                        <GradingIcon sx={{ color: 'gray' }} />
                        <p>{quizSlice.currentScore.toFixed(0)}%</p>
                    </>
                </IconAndTextWrapper>
                <IconAndTextWrapper>
                    <>
                        <MusicNoteIcon sx={{ color: 'gray' }} />
                        <p>
                            Wrong Answers: {quizSlice.incorrectPitchAttempts}/{quizSlice.quizLength}
                        </p>
                    </>
                </IconAndTextWrapper>
                <IconAndTextWrapper>
                    <>
                        <AvTimerIcon sx={{ color: 'gray' }} />
                        <p>{speed}</p>
                    </>
                </IconAndTextWrapper>
            </div>
            <br />
            {loadingContent}
            {errorContent}
            {(isLoading || quizPitchAttemptIsLoading) && <LinearProgress sx={{ maxWidth: '100%' }} />}
            <br />
            {!isLoading && !quizPitchAttemptIsLoading && (
                <>
                    <Button variant="contained" onClick={navigateHome}>
                        Home
                    </Button>
                </>
            )}
        </div>
    );
};

//useLocalStorage???
export default CompletedQuizSummaryPage;
