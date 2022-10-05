import React, {useEffect} from 'react';
import {useAppDispatch} from "../features/hooks";
import {endCompletedQuiz} from "../features/quizData/quizSlice";
import {usePatchQuizAttemptMutation} from "../features/quizData/quiz-api";
import {useSelector} from "react-redux";
import {RootState} from "../features/store";

const CompletedQuizSummaryPage = () => {
    const dispatch = useAppDispatch();
    const [patchQuizAttemptMutation, {data, isError, isLoading}] = usePatchQuizAttemptMutation();

    const quizAttemptId = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.quizAttemptId);
    const startTime = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.startTime);
    const endTime = useSelector<RootState, number | null>((state) => state.quizAttemptSlice.endTime);

    console.log("STARTTIME: " + startTime);
    console.log("ENDTIME: " + endTime);

    let completedIn: number | null;
    if (startTime && endTime) {
        completedIn = (endTime - startTime) / 1000;
    }

    useEffect(()=>{

        patchQuizAttemptMutation({
            userId: 7,
            quizAttemptId,
            completedIn
        });

    }, [])

    return (
        <div>
            <h1>Congrats on Finishing the Quiz</h1>
            {isLoading && "Sending Score to server"}
        </div>
    );
};

export default CompletedQuizSummaryPage;