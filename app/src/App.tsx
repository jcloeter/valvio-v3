import React, { useEffect, useState } from 'react';
import './App.css';
import ResponsiveAppBar from './components/layout/ResponsiveAppBar';
import { Routes, Route, useNavigate } from 'react-router-dom';
import PrimaryCard from './components/layout/PrimaryCard';
import Quizzes from './pages/Quizzes';
import QuizMode from './pages/QuizMode';
import QuizLoadingPage from './pages/QuizLoadingPage';
import CompletedQuizSummaryPage from './pages/CompletedQuizSummaryPage';
import QuizAttemptHistoryPage from './pages/QuizAttemptHistoryPage';
import AuthPage from './pages/AuthPage';
import ProfilePage from './pages/ProfilePage';
import { getAuth, onAuthStateChanged } from 'firebase/auth';
import { User } from './models/User';
import authActions, { initialAuthState } from './features/authData/authSlice';
import { useAppDispatch } from './features/hooks';

function App() {
    const dispatch = useAppDispatch();
    const navigate = useNavigate();

    const auth = getAuth();
    onAuthStateChanged(auth, async (user) => {
        const idToken = await user?.getIdToken();
        //Todo: Maybe use router to move users back to different pages

        //Firebase has logged in user
        if (user) {
            const authUser: User = {
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

        }

        //Firebase has logged out the user
        if (!user) {
            dispatch(authActions.logout(initialAuthState));
            //Todo: Handle this with Router
            if (window.location.pathname !== '/login') {
                navigate('/login');
            }
        }
    });

    return (
        <div className="App">
            <ResponsiveAppBar />
            <Routes>
                <Route
                    path={'/'}
                    element={
                        <PrimaryCard>
                            <Quizzes />
                        </PrimaryCard>
                    }
                />
                <Route path={'/login'} element={<AuthPage />} />
                <Route path={'/profile'} element={<ProfilePage />} />
                <Route path={'/dashboard'} element={<QuizAttemptHistoryPage />} />
                <Route
                    path={`/loading-quiz/:quizId`}
                    element={
                        <PrimaryCard>
                            <QuizLoadingPage />
                        </PrimaryCard>
                    }
                />
                <Route
                    path={`/quiz/:quizId`}
                    element={
                        <PrimaryCard>
                            <QuizMode />
                        </PrimaryCard>
                    }
                />
                <Route
                    path={`/completed-quiz-summary`}
                    element={
                        <PrimaryCard>
                            <CompletedQuizSummaryPage />
                        </PrimaryCard>
                    }
                />
                <Route
                    path={'/logout'}
                    element={
                        <PrimaryCard>
                            <h1>LOGOUT- Does this to be a page?</h1>
                        </PrimaryCard>
                    }
                />
                <Route
                    path="*"
                    element={
                        <PrimaryCard>
                            <h1>Page Not Found</h1>
                        </PrimaryCard>
                    }
                />
            </Routes>
        </div>
    );
}

export default App;
