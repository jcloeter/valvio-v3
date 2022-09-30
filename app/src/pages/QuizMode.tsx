import React from 'react';
import MetricsCard from "../components/ui/MetricsCard";
import QuizModeCard from "../components/ui/QuizModeCard";
import {useCreateQuizAttemptMutation} from "../features/quizData/quiz-api";

const QuizMode = () => {
    //Start Quiz
    //Get Quizzes AND put into state
    //When both are done, show first pitch to user
    //After user submits then send a request off AND update state
    //Check if the pitchesCompleted >= quizLength. If so, reveal a different component AND send a request AND update state

    return (
        <div>
            <MetricsCard/>
            <QuizModeCard/>
        </div>
    );
};

export default QuizMode;