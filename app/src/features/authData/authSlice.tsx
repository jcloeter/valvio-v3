import {createSlice, PayloadAction} from "@reduxjs/toolkit";
import {quizSlice} from "../quizData/quizSlice";
import {User} from "../../models/User";
import firebase from "firebase/compat";



export const initialAuthState: User = {
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
    creationTime:null,
    lastSignInTime: null,
    idToken: null,
}

export const authSlice = createSlice({
    name: "auth-slice",
    initialState : initialAuthState,
    reducers: {
        login: (state, action: PayloadAction<User>)=>{
            const user = action.payload;
            state.isAuthenticated = user.isAuthenticated;
            state.displayName = user.displayName;
            state.email = user.email;
            state.emailVerified = user.emailVerified;
            state.isAnonymous = user.isAnonymous;
            state.phoneNumber = user.phoneNumber;
            state.photoUrl = user.photoUrl;
            state.providerId = user.providerId;
            state.refreshToken = user.refreshToken;
            state.tenantId = user.tenantId;
            state.uid = user.uid;
            state.creationTime = user.creationTime;
            state.lastSignInTime = user.lastSignInTime;
            state.idToken = user.idToken;

        },
        logout: (state, action: PayloadAction<User>)=>{
            state.isAuthenticated = false;
            state.displayName = null;
            state.email = null;
            state.emailVerified = false;
            state.isAnonymous = false;
            state.phoneNumber = null;
            state.photoUrl = null;
            state.providerId = null;
            state.refreshToken = null;
            state.tenantId = null;
            state.uid = null;
            state.creationTime = null;
            state.lastSignInTime = null;
            state.idToken = null;
        },
     },
});


const { login, logout } = authSlice.actions;
export const authSliceReducer = authSlice.reducer;
export default authSlice.actions;