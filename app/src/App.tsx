import React, {useEffect, useState} from 'react';
import './App.css';
import ResponsiveAppBar from "./components/layout/ResponsiveAppBar";
import {Routes, Route} from 'react-router-dom';
import PrimaryCard from './components/layout/PrimaryCard';
import Quizzes from "./pages/Quizzes";
import QuizMode from "./pages/QuizMode";
import QuizLoadingPage from "./pages/QuizLoadingPage";
import CompletedQuizSummaryPage from "./pages/CompletedQuizSummaryPage";
import QuizAttemptHistoryPage from "./pages/QuizAttemptHistoryPage";
import AuthPage from "./pages/AuthPage";
import ProfilePage from "./pages/ProfilePage";


function App() {

    return (
    <div className="App">
      <ResponsiveAppBar/>
            <Routes>
                <Route path={"/"} element={<PrimaryCard><Quizzes/></PrimaryCard>}/>
                <Route path={"/login"} element={<AuthPage/>}/>
                <Route path={"/profile"} element={<ProfilePage/>}/>
                <Route path={"/dashboard"} element={<QuizAttemptHistoryPage/>}/>
                <Route path={`/loading-quiz/:quizId`} element={<PrimaryCard><QuizLoadingPage/></PrimaryCard>}/>
                <Route path={`/quiz/:quizId`} element={<PrimaryCard><QuizMode/></PrimaryCard>}/>
                <Route path={`/completed-quiz-summary`} element={<PrimaryCard><CompletedQuizSummaryPage/></PrimaryCard>}/>
                <Route path={"/logout"} element={<PrimaryCard><h1>LOGOUT- Does this to be a page?</h1></PrimaryCard>}/>
                <Route path="*" element={<PrimaryCard><h1>Page Not Found</h1></PrimaryCard>} />
            </Routes>
    </div>
  );
}

export default App;
