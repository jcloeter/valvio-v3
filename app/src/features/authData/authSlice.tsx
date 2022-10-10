import {createSlice} from "@reduxjs/toolkit";
import {quizSlice} from "../quizData/quizSlice";
import {User} from "../../models/User";


type initialAuthStateType = {
    userId: string | null,
    firebaseId: string | null,
    isAuthenticated: boolean,
    loginTime: string | null,
    expirationTime: string | null,
}

const initialAuthState: User = {
    isAuthenticated: false,
    displayName: null,
    email: null,
    emailVerified: false,
    isAnonymous: false,
    phoneNumber: null,
    photoUrl: null,
    providerId: null,
    refreshToken:null,
    tenantId: null,
    uid: null,
    createdAt: null,
    creationTime:null,
    lastLoginAt: null,
    lastSignInTime: null,
    isNewUser: false,
}

export const authSlice = createSlice({
    name: "auth-slice",
    initialState : initialAuthState,
    reducers: {
        login: (state)=>{
          state.isAuthenticated = true;
        },
        logout: (state)=>{
            state = initialAuthState;
            state.isAuthenticated = false;

        },
     },
});


const { login, logout } = authSlice.actions;
export const authSliceReducer = authSlice.reducer;
export default authSlice.actions;