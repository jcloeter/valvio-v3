import React from 'react';
import {Card, Container} from "@mui/material";
import {useNavigate} from 'react-router-dom';

//Each QuizItem needs:
// CompletionIcon Level Number: Description
// Highscore Highspeed PlayButton



const QuizItem = () => {
    const navigate = useNavigate();

    const handleQuizClick = () =>{
        navigate('/quiz');
    }

    return (
        <Container maxWidth="sm">
            <Card elevation = {0}
                  sx={{
                      margin : "10px",
                      backgroundColor: "#F8F8F8",
                      paddingTop: "25px",
                      paddingBottom: "25px",
                      // boxShadow: "rgba(0, 0, 0, 0.02) 0px 1px 3px 0px, rgba(27, 31, 35, 0.15) 0px 0px 0px 1px",
                      boxShadow: "rgba(0, 0, 0, 0.16) 0px 1px 4px",
                      "&:hover": {
                          // boxShadow: "0 16px 70px -12.125px rgba(0,0,0,0.3)"
                          // boxShadow: "rgba(0, 0, 0, 0.02) 0px 1px 3px 0px, rgba(27, 31, 35, 0.15) 0px 0px 0px 1px",
                          boxShadow: "rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px",
                          // boxShadow: "rgba(0, 0, 0, 0.1) 0px 4px 12px"
                      }
                  }}
                  onClick = {handleQuizClick}
            >
                <div>Completed   Level 1: The basics </div>
                <div> <b>100%</b>     2.3s/pitch     Play  </div>
            </Card>
        </Container>
    );
};

export default QuizItem;