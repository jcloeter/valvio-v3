import React from 'react';
import QuizList from "../components/ui/QuizList";
import {resetQuizData} from "../features/quizData/quizSlice";
import {useAppDispatch} from "../features/hooks";

const Quizzes = () => {
    const dispatch = useAppDispatch();
    dispatch(resetQuizData());

    return (
        <div>
            <QuizList/>
        </div>
    );
};

export default Quizzes;