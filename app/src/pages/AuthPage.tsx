import React, { useEffect, useState } from 'react';
import { StyledFirebaseAuth } from 'react-firebaseui';
import firebase from 'firebase/compat/app';
import 'firebase/compat/auth';
import { getAnalytics } from 'firebase/analytics';
import firebaseui, { auth as firebaseuiAuth } from 'firebaseui';
import PrimaryCard from '../components/layout/PrimaryCard';
import { useAppDispatch } from '../features/hooks';
import authActions, { initialAuthState } from '../features/authData/authSlice';
import { useNavigate } from 'react-router-dom';
import { onAuthStateChanged, getAuth } from 'firebase/auth';
import { User } from '../models/User';
import { User as firebaseUser } from 'firebase/auth';
import { useLocation } from 'react-router';
import { useCreateUserMutation, useGetUserQuery } from '../features/quizData/quiz-api';
import {Alert, CircularProgress} from "@mui/material";
import {quizSlice} from "../features/quizData/quizSlice";
import {useSelector} from "react-redux";
import {RootState} from "../features/store";

const firebaseConfig = {
    apiKey: process.env.REACT_APP_GOOGLE_AUTH_API_KEY,
    //You should probably remove a lot of this:
    authDomain: 'valvio-auth.firebaseapp.com',
    projectId: 'valvio-auth',
    storageBucket: 'valvio-auth.appspot.com',
    messagingSenderId: process.env.REACT_APP_MESSAGING_SENDER_ID,
    appId: process.env.REACT_APP_FIREBASE_AUTH_APP_ID,
    measurementId: process.env.REACT_APP_FIREBASE_AUTH_MEASUREMENT_ID,
};

const app = firebase.initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

const AuthPage = () => {
    const dispatch = useAppDispatch();
    const navigate = useNavigate();
    const location = useLocation();

    const [createUser, { data, isError: isCreateUserError, isLoading: isCreateUserLoading, isSuccess: isUserCreatedSuccess }] =
        useCreateUserMutation();

    const uiConfig = {
        signInFlow: 'redirect',
        signInSuccessUrl: '/',
        callbacks: {
            signInSuccessWithAuthResult: (authResult: firebase.auth.UserCredential, redirectUrl: string) => {
                const user = authResult.user;

                if (authResult.additionalUserInfo?.isNewUser) {
                    const body = {
                        email: user?.email,
                        isAnonymous: user?.isAnonymous,
                        displayName: user?.displayName,
                        firebaseUid: user?.uid,
                    };
                    createUser(body).then((response)=>{
                        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
                        // @ts-ignore
                        if (response && response.data && response.data.success){
                            navigate('/')
                        }
                    });
                    return false;
                }

                //From docs:
                // User successfully signed in.
                // Return type determines whether we continue the redirect automatically
                // or whether we leave that to developer to handle.
                return true;
            },
        },
        signInOptions: [
            firebase.auth.GoogleAuthProvider.PROVIDER_ID,
            firebase.auth.EmailAuthProvider.PROVIDER_ID,
            firebaseuiAuth.AnonymousAuthProvider.PROVIDER_ID,
        ],
    };

    return (
        <PrimaryCard>
            <h1>Welcome to Valvio</h1>
            <br />
            <StyledFirebaseAuth uiConfig={uiConfig} firebaseAuth={firebase.auth()} />
            {isCreateUserLoading &&
                <>
                    <CircularProgress/>
                    <h3>Creating User</h3>
                </>}
            {isCreateUserError && <Alert severity="error">There was an error syncing your acount with our servers. Please refresh and try again.</Alert>}
        </PrimaryCard>
    );
};

export default AuthPage;



