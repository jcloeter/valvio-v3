import {Quiz} from './Quiz';
import {QuizPitchAttempt} from "./QuizPitchAttempt";

export interface QuizAttempt {
    id : number,
    score: number | null,
    startedAt: string,
    completedAt : string | null,
    secondsToComplete: number | null,
    quiz: Quiz,
    quizPitchAttempts: QuizPitchAttempt[]
}