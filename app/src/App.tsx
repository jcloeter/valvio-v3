import React, {useEffect, useState} from 'react';
import './App.css';
import ResponsiveAppBar from "./components/layout/ResponsiveAppBar";
import {Routes, Route} from 'react-router-dom';
import PrimaryCard from './components/layout/PrimaryCard';
import Quizzes from "./pages/Quizzes";
import QuizMode from "./pages/QuizMode";
import QuizLoadingPage from "./pages/QuizLoadingPage";
import CompletedQuizSummaryPage from "./pages/CompletedQuizSummaryPage";



function App() {

  return (
    <div className="App">
      <ResponsiveAppBar/>
        <PrimaryCard >
            <Routes>
                <Route path={"/"} element={<Quizzes/>}/>
                <Route path={`/loading-quiz/:quizId`} element={<QuizLoadingPage/>}/>
                <Route path={`/quiz/:quizId`} element={<QuizMode/>}/>
                <Route path={`/completed-quiz-summary`} element={<CompletedQuizSummaryPage/>}/>
                <Route path={"/login"} element={<h1>LOGIN</h1>}/>
                <Route path={"/logout"} element={<h1>LOGOUT</h1>}/>
                <Route path="*" element={<h1>Page Not Found</h1>} />
            </Routes>
        </PrimaryCard>
    </div>
  );
}

export default App;
