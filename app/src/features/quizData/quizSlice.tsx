import { createSlice, PayloadAction } from '@reduxjs/toolkit';
import { quizApi } from './quiz-api';
import { Pitch } from '../../models/Pitch';
import { randomizeAndExtendPitchArray } from '../../helper/randomizeAndExtendPitchArray';
import { convertPitchInstrumentIdToImageId } from '../../helper/convertPitchInstrumentIdToImageId';
import { PitchesObject } from '../../models/PitchesObject';
import { QuizPitchAttemptDto } from '../../models/QuizPitchAttemptDto';

interface QuizSlice {
    quizId: number | null;
    userid: number | null;
    currentScore: number;
    correctPitchAttempts: number;
    incorrectPitchAttempts: number;
    uniquePitches: PitchesObject[];
    extendedPitches: PitchesObject[];
    quizPitchAttempts: QuizPitchAttemptDto[];
    isTransposition: boolean;
    transpositionInterval: number;
    transpositionDescription: string | null;
    startTime: number | null;
    endTime: number | null;
    quizStatus: 'exited' | 'in progress' | 'complete' | 'error' | 'failed' | 'uninitialized';
    quizLength: number | null;
    currentPitchIndex: number;
    quizAttemptId: number | null;
    quizName: string | null;
    quizLevel: number | null;
    isUserCorrect: boolean;
}

const initialState: QuizSlice = {
    quizId: null,
    userid: null,
    currentScore: 0,
    correctPitchAttempts: 0,
    incorrectPitchAttempts: 0,
    uniquePitches: [],
    extendedPitches: [],
    quizPitchAttempts: [],
    isTransposition: false,
    transpositionInterval: 0,
    transpositionDescription: null,
    startTime: null,
    endTime: null,
    quizStatus: 'uninitialized',
    quizLength: null,
    currentPitchIndex: 0,
    quizAttemptId: null,
    quizName: null,
    quizLevel: null,
    isUserCorrect: true,
};

export const quizSlice = createSlice({
    name: 'current-quiz-slice',
    initialState: initialState,
    reducers: {
        submitWrongAnswer: (state, action: PayloadAction<QuizPitchAttemptDto>) => {
            state.quizPitchAttempts.push(action.payload);
            state.incorrectPitchAttempts += 1;
            state.isUserCorrect = false;
            if (state.quizLength) {
                state.currentScore =
                    (100 / state.quizLength) * state.correctPitchAttempts -
                    state.incorrectPitchAttempts * (100 / state.quizLength) * 0.75;
            }
        },
        submitCorrectAnswer: (state, action: PayloadAction<QuizPitchAttemptDto>) => {
            state.quizPitchAttempts.push(action.payload);
            state.correctPitchAttempts += 1;
            state.currentPitchIndex += 1;
            state.isUserCorrect = true;
            if (state.quizLength) {
                state.currentScore =
                    (100 / state.quizLength) * state.correctPitchAttempts -
                    state.incorrectPitchAttempts * (100 / state.quizLength) * 0.75;
            }
        },
        setStartTime: (state) => {
            state.startTime = Date.now();
            state.quizStatus = 'in progress';
        },
        endCompletedQuiz: (state) => {
            state.quizStatus = 'complete';
            state.endTime = Date.now();
        },
        resetQuizData: (state) => {
            state.quizId = null;
            state.userid = null;
            state.currentScore = 0;
            state.correctPitchAttempts = 0;
            state.incorrectPitchAttempts = 0;
            state.uniquePitches = [];
            state.extendedPitches = [];
            state.isTransposition = false;
            state.transpositionInterval = 0;
            state.transpositionDescription = null;
            state.startTime = null;
            state.endTime = null;
            state.quizStatus = 'uninitialized';
            state.quizLength = null;
            state.currentPitchIndex = 0;
            state.quizAttemptId = null;
            state.quizName = null;
            state.quizLevel = null;
            state.isUserCorrect = true;
            state.quizPitchAttempts = [];
        },
        // endIncompleteQuiz: () => {},
    },
    extraReducers: (builder) => {
        builder
            .addMatcher(quizApi.endpoints.getPitchesByQuizId.matchFulfilled, (state, action) => {
                state.uniquePitches = action.payload.pitches;
                //Todo: Maybe add a new field within quizzes so that "scale" versions aren't randomized.
                state.extendedPitches = randomizeAndExtendPitchArray(action.payload.pitches, action.payload.quizLength);
                state.isTransposition = action.payload.isTransposition;
                state.quizId = action.payload.quizId;
                state.quizLength = action.payload.quizLength;

                state.transpositionDescription = action.payload.transpositionDescription;
                state.quizName = action.payload.quizName;
                state.quizLevel = action.payload.quizLevel;
            })
            .addMatcher(quizApi.endpoints.createQuizAttempt.matchFulfilled, (state, action) => {
                state.quizAttemptId = action.payload.id;
            });
    },
});

export default quizSlice.reducer;
export const { submitWrongAnswer, submitCorrectAnswer, endCompletedQuiz, setStartTime, resetQuizData } =
    quizSlice.actions;
