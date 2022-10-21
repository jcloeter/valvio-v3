export interface QuizPitchAttemptDto {
    isCorrect: boolean;
    userInput: string;
    quizPitchId: number;
    quizAttemptId: number | null;
}
