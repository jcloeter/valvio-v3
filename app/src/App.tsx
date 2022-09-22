import React, {useEffect, useState} from 'react';
import './App.css';
import ResponsiveAppBar from "./components/layout/ResponsiveAppBar";
import {Routes, Route} from 'react-router-dom';
import PrimaryCard from './components/layout/PrimaryCard';
import Quizzes from "./pages/Quizzes";


function App() {

  return (
    <div className="App">
      <ResponsiveAppBar/>

        <PrimaryCard>
            <Routes>
                <Route path={"/"} element={<Quizzes/>}/>
                <Route path={"/play"} element={<h1>PLAY</h1>}/>
                <Route path={"/login"} element={<h1>LOGIN</h1>}/>
                <Route path={"/logout"} element={<h1>LOGOUT</h1>}/>
            </Routes>
        </PrimaryCard>
    </div>
  );
}

export default App;
