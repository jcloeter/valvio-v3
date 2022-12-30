import React, { useEffect } from 'react';
import QuizItem from './QuizItem';
import {
    useGetQuizAttemptCollectionByUserQuery,
    useGetQuizzesQuery,
    useGetUserQuery
} from '../../features/quizData/quiz-api';
import { converQuizAttemptsToHighScores } from '../../helper/convertQuizAttemptsToHighScores';
import { Quiz } from '../../models/Quiz';
import { QuizAttempt } from '../../models/QuizAttempt';
import VCircularProgress from '../accessories/VCircularProgress';
import { RootState } from '../../features/store';
import { useSelector } from 'react-redux';
import LightGreyCard from "./LightGreyCard";
import {Alert} from "@mui/material";

const QuizList = () => {
    const authSlice = useSelector((state: RootState) => state.authSlice);
    const { data: quizzesObj, isLoading, isError, error } = useGetQuizzesQuery({});

    useEffect(()=>{
        const hash: string = new URL(document.URL).hash.slice(1);
        const element = document.getElementById(hash);
        if (element){
            element.scrollIntoView({behavior: "smooth"});
        }
    }, [quizzesObj])


    const {
        data: quizAttempts,
        refetch: refetchQuizAttempts,
        isLoading: isQuizAttemptsLoading,
        isError: isQuizAttemptsError,
        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-ignore
    } = useGetQuizAttemptCollectionByUserQuery(authSlice.uid);

    let errorMessage: JSX.Element | null = null;

    useEffect(() => {
        refetchQuizAttempts();
    }, [refetchQuizAttempts, authSlice.uid]);

    if (isError || isQuizAttemptsError) {
        errorMessage = <Alert severity="error">There was an error. Refresh your page to try again.</Alert>;
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

    const units: string[] = []

    if (quizzesObj){
        quizzesObj.quizzes.map((quiz: Quiz)=>{
            if (!units.includes(quiz.difficulty)){
                units.push(quiz.difficulty)
            }
        })
    }

    return (
        <div>
            <h1>Trumpet Quizzes</h1>
            <br />
            {errorMessage}
            {units.map((unit: string, index: number) => {
                return (
                    <LightGreyCard key={index}>
                        <>
                            <h3>Unit {index+1}: {unit}</h3>
                            <br/>
                            {quizzesObj?.quizzes.map((quiz: Quiz, index: number) => {
                                if (quizAttempts?.quizAttempts) {
                                    highScores = converQuizAttemptsToHighScores(quizAttempts.quizAttempts);
                                }

                                if (unit != quiz.difficulty){
                                    return;
                                }


                                return (
                                    <QuizItem
                                        id ={quiz.id}
                                        key={index}
                                        quiz={quiz}
                                        highScores={highScores}
                                        areQuizAttemptsLoading={isQuizAttemptsLoading}
                                    />
                                );
                            })}
                        </>
                    </LightGreyCard>
                );
            })}

        </div>
    );
};

export default QuizList;
