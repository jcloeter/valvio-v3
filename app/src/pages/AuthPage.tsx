import React from 'react';
import {StyledFirebaseAuth} from "react-firebaseui";
import firebase from 'firebase/compat/app';
import 'firebase/compat/auth';
import { getAnalytics } from "firebase/analytics";
import firebaseui, { auth as firebaseuiAuth } from 'firebaseui';
import PrimaryCard from "../components/layout/PrimaryCard";
import {useAppDispatch} from "../features/hooks";
import authActions, {initialAuthState} from '../features/authData/authSlice';
import {useNavigate} from "react-router-dom";
import {onAuthStateChanged, getAuth} from 'firebase/auth';
import {User} from "../models/User";
import {User as firebaseUser} from 'firebase/auth';
import {useLocation} from "react-router";
// import auth = firebase.auth;
// import Auth = firebase.auth.Auth;

const firebaseConfig = {
    apiKey: process.env.REACT_APP_GOOGLE_AUTH_API_KEY,
    //You should probably remove a lot of this:
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
    const location = useLocation();

    const uiConfig = {
        signInFlow: 'popup',
        signInSuccessUrl: '/',
        callbacks: {
            signInSuccessWithAuthResult: (authResult: firebase.auth.UserCredential, redirectUrl: string) => {
                //After successful sign in:
                // if user is new
                    // save the uid and user info in the database
                // if the user is not new
                    //
                // Save the token in localstorage
                // Update the authSlice using dispatch(login(authResult));


                //When client makes a request:
                // retrieve firebase tokenId from localstorage and attach to api-slice
                // retrieve accessToken from localstorage and attach to api-slice
                    // this ensures that ONLY user with the proper id may modify their own data
                // pass all routes through a preliminary controller
                // send a request to firebase for valid auth token
                // send a request to firebase to validate that the uid matches the access token
                // if the token is valid, proceed with request


                //When a user refreshes:
                // Check for a token in localstorage
                // Make a request to firebase to validate the token?
                // if the token is good, fill the auth slice with the returned data from firebase


                //When a user signs out:
                // delete token from localStorage
                // dispatch(logout) to clear data from redux
                // Then do I need to 'tell' firebase that the user is logged out?
                // Do I need to 'tell' the backend that a user has been logged out?
                // Then what about the access token- will that still be valid?
                // Call signout(auth) from firebase


                //Notes from Kyle:
                //localStorage probably not necessary, there is auth happening behind the scenes
                // accessToken vs idToken- find out how to validate on backend


                // firebase.auth().currentUser?.getIdToken(true).then((idToken: string)=>{
                //     console.log("Your id token is:");
                //     console.log(idToken);
                // })

                console.log(authResult)
                // if (authResult.user){
                //     if (authResult.additionalUserInfo?.isNewUser){
                //         console.log("WE HAVE A NEW USER!!!");
                //     } else {
                //         console.log("Welcome back, existing user");
                //
                //     }
                //     console.log(authResult.credential)
                //     console.log(authResult.user?.uid)
                //     localStorage.setItem("uid", authResult.user?.uid);
                // }
                // navigate(redirectUrl);


                if (authResult.additionalUserInfo?.isNewUser){
                    console.log("CREATING USER IN BACKEND HERE!!!");
                }

                return false;
            },
        },
        signInOptions: [
            firebase.auth.GoogleAuthProvider.PROVIDER_ID,
            firebase.auth.EmailAuthProvider.PROVIDER_ID,
            firebaseuiAuth.AnonymousAuthProvider.PROVIDER_ID,
        ],
    };

    const auth = getAuth();
    onAuthStateChanged(auth, (async (user ) => {
        console.log("onAuthStateChanged");
        console.log(user);

        const idToken = await user?.getIdToken();

        if (user){
            const authUser : User = {
                isAuthenticated: true,
                displayName: user.displayName,
                email: user.email,
                emailVerified: user.emailVerified,
                isAnonymous: user.isAnonymous,
                phoneNumber: user.phoneNumber,
                photoUrl: user.photoURL,
                providerId: user.providerId,
                refreshToken: user.refreshToken,
                tenantId: user.tenantId,
                uid: user.uid,
                creationTime: null,
                lastSignInTime: null,
                idToken: idToken,
            };

            dispatch(authActions.login(authUser));
            navigate('/profile');
        }

        if (!user) {
            console.log(location.pathname);
            console.log(window.location.pathname);
            if (window.location.pathname !== "/login"){
                navigate('/login');
            }
        }

        //Start here next: When a user refreshes the page on any page other than the /login page, their credentials are lost from redux
        //What needs to happen is that we trigger the lookup somehow no matter what page we are on, retrieve them, and reinit the redux state

        // firebase.auth().currentUser?.getIdToken(true).then((idToken: string)=>{
        //     console.log("Your id token is:");
        //     console.log(idToken);
        // })

        user?.getIdToken();

        if (!user) {
            console.log("there us no current user signed in- resetting redux store now to reflect that");
            // dispatch(authActions.logout(initialAuthState))
        }
    }))

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