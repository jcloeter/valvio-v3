import React, {useEffect, useMemo} from 'react';
import MetricsCard from "../components/ui/MetricsCard";
import QuizModeCard from "../components/ui/QuizModeCard";
import {useSelector} from "react-redux";
import {RootState} from "../features/store";
import {QuizAttempt} from "../models/QuizAttempt";
import QuizSlice from "../features/quizData/quizSlice";
import {useNavigate} from "react-router-dom";
import {QuizPitchAttemptDto} from "../models/QuizPitchAttemptDto";


const QuizMode = () => {
    const navigate = useNavigate();
    const quizStatus = useSelector<RootState>((state) => state.quizAttemptSlice.quizStatus);

    // const quizPitchAttemptArray : QuizPitchAttemptDto[] = [];
    //
    // const registerQuizAttempt = (quizAttempt: QuizPitchAttemptDto) => {
    //     quizPitchAttemptArray.push(quizAttempt);
    // }

    //Todo: Fix all this so it can redirect if there is an error:

    // useEffect(()=>{
    //     if (quizStatus === "uninitialized") {
    //         navigate('/');
    //     }
    // }, [quizStatus])


    return (
        <div>
            <MetricsCard/>
            <QuizModeCard/>
        </div>
    );
};

export default QuizMode;