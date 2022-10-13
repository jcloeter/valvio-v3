import React, {useEffect} from 'react';
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
import {useCreateUserMutation} from "../features/quizData/quiz-api";
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

    const [createUser, {data, error, isError: isCreateUserError, isLoading: isCreateUserLoading}] = useCreateUserMutation();

    const uiConfig = {
        signInFlow: 'popup',
        signInSuccessUrl: '/',
        callbacks: {
            signInSuccessWithAuthResult: (authResult: firebase.auth.UserCredential, redirectUrl: string) => {

                if (authResult.additionalUserInfo?.isNewUser){
                    console.log("CREATING USER IN BACKEND HERE!!!");
                    const user = authResult.user;
                    const body = {
                        email: user?.email,
                        isAnonymous: user?.isAnonymous,
                        displayName: user?.displayName,
                        firebaseUid: user?.uid,
                    }

                    console.log(body);
                   createUser(body);
                   // if (!isCreateUserLoading || !isCreateUserError) {
                   //     console.log("successfully created your use ")
                   //     navigate('/profile');
                   // }
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

    // onAuthStateChanged(auth, (async (user ) => {
    //     // console.log("onAuthStateChanged");
    //     // console.log(user);
    //
    //     // const idToken = await user?.getIdToken();
    //     //
    //     // if (user){
    //     //     const authUser : User = {
    //     //         isAuthenticated: true,
    //     //         displayName: user.displayName,
    //     //         email: user.email,
    //     //         emailVerified: user.emailVerified,
    //     //         isAnonymous: user.isAnonymous,
    //     //         phoneNumber: user.phoneNumber,
    //     //         photoUrl: user.photoURL,
    //     //         providerId: user.providerId,
    //     //         refreshToken: user.refreshToken,
    //     //         tenantId: user.tenantId,
    //     //         uid: user.uid,
    //     //         creationTime: null,
    //     //         lastSignInTime: null,
    //     //         idToken: idToken,
    //     //     };
    //     //
    //     //     dispatch(authActions.login(authUser));
    //     //     navigate('/profile');
    //     // }
    //     //
    //     // if (!user) {
    //     //     console.log(location.pathname);
    //     //     console.log(window.location.pathname);
    //     //     if (window.location.pathname !== "/login"){
    //     //         navigate('/login');
    //     //     }
    //     // }
    //
    //     // firebase.auth().currentUser?.getIdToken(true).then((idToken: string)=>{
    //     //     console.log("Your id token is:");
    //     //     console.log(idToken);
    //     // })
    //
    //
    //     if (!user) {
    //         console.log("there us no current user signed in- resetting redux store now to reflect that");
    //         // dispatch(authActions.logout(initialAuthState))
    //     }
    // }))

    //If there !isError or !isLoading AND there is data then you should navigate away
    //But what if login went smoothly with an old account???


    //This is always returning null despite what App.tsx is saying- weird...
    // const auth = getAuth();
    // console.log(auth);
    // const user = auth.currentUser;
    //
    // if (user?.uid) {
    //     console.log(user)
    //     navigate('/')
    // } else {
    //     console.log(user?.uid)
    // }

    useEffect(()=>{
        if (data && !isCreateUserLoading && !isCreateUserError){
            navigate('/')
        }
    },[data, isCreateUserError, isCreateUserLoading])


    return (
        <PrimaryCard>
            <h1>Welcome to Valvio</h1>
            <p>Please sign-in to save scores:</p>
            <br/>
            <StyledFirebaseAuth uiConfig={uiConfig} firebaseAuth={firebase.auth()} />
            {isCreateUserLoading && "Creating User ..."}
            {isCreateUserError && "There was an error syncing your acount with our servers. Please try again."}
        </PrimaryCard>
    );
};

export default AuthPage;


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