import {createSlice} from "@reduxjs/toolkit";

//Todo: Add createQuizPitchAttempt, PATCH quizAttempt
//Todo: update slices before sending the request!!!


const initialState = {
    quizId: 0,
    userid: 7,
    currentScore: 0,
    correctPitchAttempts: 0,
    incorrectPitchAttempts: 0,
    pitches: "no pitches",
};

export const quizSlice = createSlice({
    name: "current-quiz-slice",
    initialState : initialState,
    reducers: {
        setPitches: (state, pitchesArr)=>{
            state.pitches = "PITCHES";
        },
        submitWrongAnswer: (state)=>{
            state.incorrectPitchAttempts += 1
        },
        submitCorrectAnswer: (state)=>{
            state.correctPitchAttempts += 1;
        },
        viewTotalScore: ()=>{}
    }
});

export default quizSlice.reducer;
export const { setPitches, submitWrongAnswer, submitCorrectAnswer } = quizSlice.actions;