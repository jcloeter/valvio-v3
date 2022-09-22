import React, {useEffect, useState} from 'react';
import './App.css';
import ResponsiveAppBar from "./components/layout/ResponsiveAppBar";
import {Routes, Route} from 'react-router-dom';

function App() {

  return (
    <div className="App">
      <ResponsiveAppBar/>
        <Routes>
            <Route path={"/quizzes"} element={<h1>QUIZZES</h1>}/>
            <Route path={"/play"} element={<h1>PLAY</h1>}/>
            <Route path={"/login"} element={<h1>LOGIN</h1>}/>
            <Route path={"/logout"} element={<h1>LOGOUT</h1>}/>
            github test
        </Routes>
    </div>
  );
}

export default App;
