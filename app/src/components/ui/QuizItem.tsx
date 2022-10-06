import React, {useEffect, useState} from 'react';
import {Card, CircularProgress, Container, LinearProgress} from "@mui/material";
import {useNavigate} from 'react-router-dom';
import {Quiz} from '../../models/Quiz';
import QuizItemPersonalMetrics from "./QuizItemPersonalMetrics";
import {QuizAttempt} from "../../models/QuizAttempt";

import CheckCircleOutlineOutlinedIcon from '@mui/icons-material/CheckCircleOutlineOutlined';
import CheckCircleTwoToneIcon from '@mui/icons-material/CheckCircleTwoTone';
import CheckBoxOutlineBlankTwoToneIcon from '@mui/icons-material/CheckBoxOutlineBlankTwoTone';
import RadioButtonUncheckedTwoToneIcon from '@mui/icons-material/RadioButtonUncheckedTwoTone';
import Button from "@mui/material/Button";
import AccessTimeIcon from '@mui/icons-material/AccessTime';
import RepeatIcon from '@mui/icons-material/Repeat';
import AssignmentIcon from '@mui/icons-material/Assignment';
import MetricIcons from "./MetricIcons";
import styles from "./Metricicons.module.css";
import quizItemStyles from "./QuizItem.module.css";

const QuizItem: React.FC<{quiz: Quiz, highScores: QuizAttempt[], areQuizAttemptsLoading: boolean}>= (props) => {
    const [showDetails, setShowDetails] = useState(false);

    const navigate = useNavigate();

    const handleCardClick = () =>{
        setShowDetails((showDetails: boolean)=>{
            return !showDetails;
        })
    }

    const handlePlayQuizClick=()=>{
        navigate(`/loading-quiz/${props.quiz.id}`);
    }

    let highScore: QuizAttempt | undefined = props.highScores.find((quizAttempt: QuizAttempt)=>{
        if (quizAttempt.quiz.id === props.quiz.id){
            return quizAttempt;
        }
    })


    let scoreIcon;

    if (highScore?.score === 100) {
        scoreIcon = <CheckCircleTwoToneIcon sx={{color: "green"}}/>
    } else if (highScore?.score && highScore?.score > 0) {
        scoreIcon = <CheckCircleOutlineOutlinedIcon sx={{color: "purple"}}/>
    } else {
        scoreIcon = <RadioButtonUncheckedTwoToneIcon sx={{color: "purple"}}/>
    }

    if (props.areQuizAttemptsLoading){
        scoreIcon = <CircularProgress size = {18}/>
    }


    return (
        <Container maxWidth="sm" key = {props.quiz.id}>
            <Card elevation = {0}
                  sx={{
                      margin : "10px",
                      backgroundColor: "#F8F8F8",
                      paddingTop: "10px",
                      paddingBottom: "10px",
                      boxShadow: "rgba(0, 0, 0, 0.16) 0px 1px 4px",
                      "&:hover": {
                          boxShadow: "rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px",
                      },
                      display: "flex",
                      flexDirection: "column",
                      // justifyContent: "center",
                      alignItems: "center",
                  }}
                  onClick = {handleCardClick}
            >

                <div className = {quizItemStyles["icon-level-container"]}>
                    <div>{scoreIcon}</div>
                    <div>Level {props.quiz.level}. {props.quiz.name}</div>

                    {/*<div>{props.quiz.transposition.interval}</div>*/}
                    {/*<div>{props.quiz.transposition.name}</div>*/}
                </div>




                <MetricIcons>
                    <ul className={styles["metric-icons-ul"]}>
                        <li className={styles["metric-icons-li"]}>
                            <AssignmentIcon sx={{color : "gray"}}/>
                            {(highScore?.score) ? <b>{(highScore?.score).toFixed(0)}%</b> : <b>0%</b>}
                        </li>
                        <li className={styles["metric-icons-li"]}>
                            <AccessTimeIcon sx={{color : "gray"}}/>
                            {
                                highScore?.secondsToComplete ? <b>{(highScore?.secondsToComplete / props.quiz.length).toFixed(2)}s/pitch</b> : <b>n/a</b>
                            }
                        </li>
                        <li className={styles["metric-icons-li"]}>
                            <RepeatIcon sx={{color : "gray"}}/>
                            <b>3</b>
                        </li>

                    </ul>
                </MetricIcons>



                <br/>

                {showDetails &&
                    <>
                        <div>{props.quiz.description}</div>
                        <Button variant="outlined" onClick={handlePlayQuizClick}>Play</Button>
                    </> }

            </Card>
        </Container>
    );
};

export default QuizItem;