import React from 'react';
import {StyledFirebaseAuth} from "react-firebaseui";
import firebase from 'firebase/compat/app';
import 'firebase/compat/auth';
import { getAnalytics } from "firebase/analytics";
import firebaseui, { auth as firebaseuiAuth } from 'firebaseui';
import PrimaryCard from "../components/layout/PrimaryCard";
import {useAppDispatch} from "../features/hooks";
import authActions from '../features/authData/authSlice';
import {useNavigate} from "react-router-dom";

const firebaseConfig = {
    apiKey: process.env.REACT_APP_GOOGLE_AUTH_API_KEY,
    authDomain: "valvio-auth.firebaseapp.com",
    projectId: "valvio-auth",
    storageBucket: "valvio-auth.appspot.com",
    messagingSenderId: "894892883479",
    appId: "1:894892883479:web:5c48799b121f3f08436652",
    measurementId: "G-B49CCTRBMW"
};

const app = firebase.initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

const AuthPage = () => {
    const dispatch = useAppDispatch();
    const navigate = useNavigate();

    const uiConfig = {
        signInFlow: 'popup',
        signInSuccessUrl: '/profile',
        callbacks: {
            signInSuccessWithAuthResult: (authResult: firebase.auth.UserCredential, redirectUrl: string) => {
                //Create helper: createUserFromAuthResult();

                // const user = authResult.user.id;
                dispatch(authActions.login());
                console.log(authResult)
                // navigate(redirectUrl);
                return false;
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
            <p>Please sign-in to save scores:</p>
            <br/>
            <StyledFirebaseAuth uiConfig={uiConfig} firebaseAuth={firebase.auth()} />
        </PrimaryCard>
    );
};

export default AuthPage;