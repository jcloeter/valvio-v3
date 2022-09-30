import {QuizAttempt} from "../models/QuizAttempt";


export const converQuizAttemptsToHighScores=(quizAttempts: QuizAttempt[])=>{
    const highScoreArray: QuizAttempt[] = [];
    quizAttempts.map((quizAttempt: QuizAttempt, index: number, originalArray:QuizAttempt[])=>{
        if (!quizAttempt.completedAt) return false;
        if (!quizAttempt.secondsToComplete) return false;

        const isAnotherScoreHigherFromSameQuiz = originalArray.some((originalQuizAttempt: QuizAttempt, i: number)=>{

            if (quizAttempt.quiz.id === originalQuizAttempt.quiz.id){
                // console.log("Found two results from the same quiz!");

                // @ts-ignore
                if (originalQuizAttempt.score > quizAttempt.score) {
                    return true
                }

                if (originalQuizAttempt.score === quizAttempt.score) {
                    // @ts-ignore
                    if (originalQuizAttempt.secondsToComplete < quizAttempt.secondsToComplete) {
                        return true;
                    }
                }
                return false;
            }
        })

        if (!isAnotherScoreHigherFromSameQuiz) {
            highScoreArray.push(quizAttempt);
        }
    })

    return highScoreArray;
}