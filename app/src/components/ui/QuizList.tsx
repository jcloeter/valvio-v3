import React, {useEffect} from 'react';
import QuizItem from "./QuizItem";
import {useGetQuizAttemptCollectionByUserQuery, useGetQuizzesQuery} from "../../features/quizData/quiz-api";
import {converQuizAttemptsToHighScores} from "../../helper/convertQuizAttemptsToHighScores";
import {Quiz} from "../../models/Quiz";
import {QuizAttempt} from "../../models/QuizAttempt";
import VCircularProgress from "../accessories/VCircularProgress";


const QuizList = () => {
    const {data: quizzesObj, isLoading, isError, error} = useGetQuizzesQuery({});
    const {data: quizAttempts, isLoading: isQuizAttemptsLoading, isError: isQuizAttemptsError} = useGetQuizAttemptCollectionByUserQuery(7);

    if (isError || isQuizAttemptsError) {
        return <h2>error</h2>
    }

    if (isLoading && isQuizAttemptsLoading){
        return (
            <>
                <h3>Loading Quizzes</h3>
                <VCircularProgress/>
            </>
        );
    }

    let highScores: QuizAttempt[] =[];

    return (
        <div>
            <h3>Trumpet Quizzes</h3>
            {quizzesObj?.quizzes.map((quiz: Quiz, index: number)=>{
                if (quizAttempts?.quizAttempts){
                    highScores = converQuizAttemptsToHighScores(quizAttempts.quizAttempts);
                    console.log(highScores);
                }
                return <QuizItem key={index} quiz = {quiz} highScores = {highScores}
                />}
            )}
        </div>
    );
};

export default QuizList;
