import React, { useEffect } from 'react';
import QuizItem from './QuizItem';
import { useGetQuizAttemptCollectionByUserQuery, useGetQuizzesQuery } from '../../features/quizData/quiz-api';
import { converQuizAttemptsToHighScores } from '../../helper/convertQuizAttemptsToHighScores';
import { Quiz } from '../../models/Quiz';
import { QuizAttempt } from '../../models/QuizAttempt';
import VCircularProgress from '../accessories/VCircularProgress';
import { RootState } from '../../features/store';
import { useSelector } from 'react-redux';

const QuizList = () => {
    const authSlice = useSelector((state: RootState) => state.authSlice);
    const { data: quizzesObj, isLoading, isError, error } = useGetQuizzesQuery({});
    // @ts-ignore
    const {
        data: quizAttempts,
        refetch: refetchQuizAttempts,
        isLoading: isQuizAttemptsLoading,
        isError: isQuizAttemptsError,
    } = useGetQuizAttemptCollectionByUserQuery(authSlice.uid);

    useEffect(() => {
        refetchQuizAttempts();
    }, [refetchQuizAttempts]);

    if (isError || isQuizAttemptsError) {
        return <h2>There was an error. Refresh your page to try again.</h2>;
    }

    if (isLoading) {
        return (
            <>
                <h3>Loading Quizzes</h3>
                <br />
                <VCircularProgress />
            </>
        );
    }

    let highScores: QuizAttempt[] = [];

    return (
        <div>
            <h3>Trumpet Quizzes</h3>
            <br />
            {quizzesObj?.quizzes.map((quiz: Quiz, index: number) => {
                if (quizAttempts?.quizAttempts) {
                    highScores = converQuizAttemptsToHighScores(quizAttempts.quizAttempts);
                }
                return (
                    <QuizItem
                        key={index}
                        quiz={quiz}
                        highScores={highScores}
                        areQuizAttemptsLoading={isQuizAttemptsLoading}
                    />
                );
            })}
        </div>
    );
};

export default QuizList;
