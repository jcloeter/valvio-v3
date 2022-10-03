import React, {useEffect, useMemo} from 'react';
import MetricsCard from "../components/ui/MetricsCard";
import QuizModeCard from "../components/ui/QuizModeCard";
import {useSelector} from "react-redux";
import {RootState} from "../features/store";


const QuizMode = () => {
    console.log("At least quiz mode is working")
    const quizAttemptSlice = useSelector<RootState>((state) => state.quizAttemptSlice);

    return (
        <div>
            <MetricsCard/>
            <QuizModeCard/>
        </div>
    );
};

export default QuizMode;