import {createSlice} from "@reduxjs/toolkit";
import {quizApi} from "./quiz-api";
import {Pitch} from "../../models/Pitch";
import {randomizeAndExtendPitchArray} from "../../helper/randomizeAndExtendPitchArray";
import {convertPitchInstrumentIdToImageId} from "../../components/ui/convertPitchInstrumentIdToImageId";

//Todo: Add createQuizPitchAttempt, PATCH quizAttempt
//Todo: update slices before sending the request!!!

interface QuizSlice {
    quizId: number | null,
    userid: number | null
    currentScore: number,
    correctPitchAttempts: number,
    incorrectPitchAttempts: number,
    uniquePitches: Pitch[],
    extendedPitches: Pitch[],
    isTransposition: boolean,
    transpositionInterval: number,
    startTime: number | null,
    endTime: number | null,
    quizStatus:  "exited" | "in progress" | "complete" | "error" | "failed" | "uninitialized" ;
    quizLength: number | null,
    currentPitchIndex: number,
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
        },
        setStartTime: (state) =>{
            state.startTime = Date.now();
        },
        viewTotalScore: ()=>{}
    },
    extraReducers: (builder) => {
        builder
            .addMatcher(quizApi.endpoints.getPitchesByQuizId.matchFulfilled, (state, action)=> {
                state.uniquePitches = action.payload.pitches;
                state.extendedPitches = randomizeAndExtendPitchArray(action.payload.pitches, action.payload.quizLength);
                state.isTransposition = action.payload.isTransposition;
                state.quizId = action.payload.quizId;
            })
    }
});

export default quizSlice.reducer;
export const { submitWrongAnswer, submitCorrectAnswer } = quizSlice.actions;