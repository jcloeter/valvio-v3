import {Pitch} from "./Pitch";

export interface QuizPitchAttempt {
    isCorrect: boolean,
    quizPitchAttemptId: number,
    userInput: string,
    pitch: Pitch,
    transposedAnswerPitch: Pitch
}