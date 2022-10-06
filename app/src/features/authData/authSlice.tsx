import {createSlice} from "@reduxjs/toolkit";
import {quizSlice} from "../quizData/quizSlice";


type initialAuthStateType = {
    userId: string | null,
    firebaseId: string | null,
    isAuthenticated: boolean,
    loginTime: string | null,
    expirationTime: string | null,
}

const initialAuthState: initialAuthStateType = {
    userId : null,
    firebaseId: null,
    isAuthenticated: false,
    loginTime: null,
    expirationTime: null,

}

export const authSlice = createSlice({
    name: "auth-slice",
    initialState : initialAuthState,
    reducers: {
        login: (state)=>{
          state.isAuthenticated = true;
          // state.userId = userId;
        },
        logout: (state)=>{
            state.isAuthenticated = false;
        }}
});


const { login, logout } = authSlice.actions;
export default authSlice.actions;