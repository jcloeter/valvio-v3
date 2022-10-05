import {createSlice} from "@reduxjs/toolkit";
import {quizApi} from "./quiz-api";
import {Pitch} from "../../models/Pitch";
import {randomizeAndExtendPitchArray} from "../../helper/randomizeAndExtendPitchArray";
import {convertPitchInstrumentIdToImageId} from "../../components/ui/convertPitchInstrumentIdToImageId";
import {PitchesObject} from "../../models/PitchesObject";


interface QuizSlice {
    quizId: number | null,
    userid: number | null
    currentScore: number,
    correctPitchAttempts: number,
    incorrectPitchAttempts: number,
    uniquePitches: PitchesObject[],
    extendedPitches: PitchesObject[],
    isTransposition: boolean,
    transpositionInterval: number,
    startTime: number | null,
    endTime: number | null,
    quizStatus:  "exited" | "in progress" | "complete" | "error" | "failed" | "uninitialized" ;
    quizLength: number | null,
    currentPitchIndex: number,
    quizAttemptId: number | null,
}

const initialState: QuizSlice= {
    quizId: null,
    userid: null,
    currentScore: 0,
    correctPitchAttempts: 0,
    incorrectPitchAttempts: 0,
    uniquePitches: [],
    extendedPitches: [],
    isTransposition: false,
    transpositionInterval: 0,
    startTime: null,
    endTime: null,
    quizStatus: "uninitialized",
    quizLength: null,
    currentPitchIndex: 0,
    quizAttemptId: null,
};

export const quizSlice = createSlice({
    name: "current-quiz-slice",
    initialState : initialState,
    reducers: {
        submitWrongAnswer: (state)=>{
            state.incorrectPitchAttempts += 1
        },
        submitCorrectAnswer: (state)=>{
            state.correctPitchAttempts += 1;
            state.currentPitchIndex += 1;
            if (state.quizLength){
                state.currentScore += 100/(state.quizLength);
            }
        },
        setStartTime: (state) =>{
            state.startTime = Date.now();
            state.quizStatus = "in progress";
        },
        endCompletedQuiz: (state) => {
            state.quizStatus = "complete";
            state.endTime = Date.now();
        },
        endIncompleteQuiz: () =>{},
    },
    extraReducers: (builder) => {
        builder
            .addMatcher(quizApi.endpoints.getPitchesByQuizId.matchFulfilled, (state, action)=> {
                state.uniquePitches = action.payload.pitches;
                state.extendedPitches = randomizeAndExtendPitchArray(action.payload.pitches, action.payload.quizLength);
                state.isTransposition = action.payload.isTransposition;
                state.quizId = action.payload.quizId;
                state.quizLength = action.payload.quizLength;
            })
            .addMatcher(quizApi.endpoints.createQuizAttempt.matchFulfilled, (state, action)=>{
                state.quizAttemptId = action.payload.id;
            })
    }
});

export default quizSlice.reducer;
export const { submitWrongAnswer, submitCorrectAnswer, endCompletedQuiz, setStartTime } = quizSlice.actions;