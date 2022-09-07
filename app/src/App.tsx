import React, {useEffect} from 'react';
import logo from './logo.svg';
import './App.css';
import {Button} from "@mui/material";
import axios from "axios";



function App() {
  const handleOnClick=()=>{
    console.log("click")
    axios.get("http://localhost:8000/test/quizzes/2").then(res=>{
          console.log(res);
        }
    )
  }

  useEffect(()=>{
      axios.get("http://localhost:8000/log/howdy").then(res=>{
              console.log(res);
          }
      )
  }, [])

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <Button onClick = {handleOnClick}>
          Learn React
        </Button>
      </header>
    </div>
  );
}

export default App;
