import React, { useEffect, useState } from 'react';
import { Card, CircularProgress, Container, LinearProgress } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import { Quiz } from '../../models/Quiz';
import QuizItemPersonalMetrics from './QuizItemPersonalMetrics';
import { QuizAttempt } from '../../models/QuizAttempt';

import CheckCircleOutlineOutlinedIcon from '@mui/icons-material/CheckCircleOutlineOutlined';
import CheckCircleTwoToneIcon from '@mui/icons-material/CheckCircleTwoTone';
import CheckBoxOutlineBlankTwoToneIcon from '@mui/icons-material/CheckBoxOutlineBlankTwoTone';
import RadioButtonUncheckedTwoToneIcon from '@mui/icons-material/RadioButtonUncheckedTwoTone';
import Button from '@mui/material/Button';
import AccessTimeIcon from '@mui/icons-material/AccessTime';
import RepeatIcon from '@mui/icons-material/Repeat';
import AssignmentIcon from '@mui/icons-material/Assignment';
import MetricIcons from './MetricIcons';
import styles from './Metricicons.module.css';
import quizItemStyles from './QuizItem.module.css';
import { useGetQuizAttemptCollectionByUserQuery } from '../../features/quizData/quiz-api';
import { useSelector } from 'react-redux';
import { RootState } from '../../features/store';
import QuizDescriptionChip from "./QuizDescriptionChip";

const QuizItem: React.FC<{ quiz: Quiz; highScores: QuizAttempt[]; areQuizAttemptsLoading: boolean; id: number }> = (props) => {
    const [showDetails, setShowDetails] = useState(false);
    const authSlice = useSelector((state: RootState) => state.authSlice);
    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    const { data: quizAttempts, refetch: refetchQuizAttempts } = useGetQuizAttemptCollectionByUserQuery(authSlice.uid);

    const findCompletedQuizAttemptsForQuizId = () => {
        if (!quizAttempts) return [];
        let quizAttemptsForCurrentQuiz = [];

        quizAttemptsForCurrentQuiz = quizAttempts.quizAttempts.map((qa: any) => {
            if (qa.quiz.id === props.quiz.id && qa.completedAt) {
                return qa;
            }
        });

        const filteredQuizAttempts = quizAttemptsForCurrentQuiz.filter((qa: any) => {
            //Start here
            if (qa?.id) {
                return true;
            }
            return false;
        });

        return filteredQuizAttempts.length;
    };

    const numberOfCompletedQuizAttemptsForQuiz = findCompletedQuizAttemptsForQuizId();

    const navigate = useNavigate();

    const handleCardClick = () => {
        navigate(`/loading-quiz/${props.quiz.id}`);

        // setShowDetails((showDetails: boolean) => {
        //     return !showDetails;
        // });
    };

    //Clicking on card takes user directly to game
    // const handlePlayQuizClick = () => {
    //     navigate(`/loading-quiz/${props.quiz.id}`);
    // };

    const highScore: QuizAttempt | undefined = props.highScores.find((quizAttempt: QuizAttempt) => {
        if (quizAttempt.quiz.id === props.quiz.id) {
            return quizAttempt;
        }
    });

    let scoreIcon;

    if (highScore?.score === 100) {
        scoreIcon = <CheckCircleTwoToneIcon sx={{ color: 'green' }} />;
    } else if (highScore?.score && highScore?.score > 0) {
        scoreIcon = <CheckCircleOutlineOutlinedIcon sx={{ color: 'purple' }} />;
    } else {
        scoreIcon = <RadioButtonUncheckedTwoToneIcon sx={{ color: 'purple' }} />;
    }

    if (props.areQuizAttemptsLoading) {
        scoreIcon = <CircularProgress size={18} />;
    }

    return (
        <Container maxWidth="md" key={props.quiz.id}>
            <Card
                elevation={0}
                sx={{
                    marginTop: '20px',
                    backgroundColor: '#F8F8F8',

                    padding: '10px',
                    boxShadow: 'rgba(0, 0, 0, 0.16) 0px 1px 4px',
                    '&:hover': {
                        boxShadow: 'rgba(0, 0, 0, 0.16) 0px 3px 6px, rgba(0, 0, 0, 0.23) 0px 3px 6px',
                    },
                    display: 'flex',
                    flexDirection: 'column',
                    justifyContent: 'flex-start',
                    alignItems: 'flex-start',
                }}
                onClick={handleCardClick}
            >
                {/*This is where we are handling the id link:*/}
                <div id = {props.quiz.id.toString()} className={quizItemStyles['icon-level-container']}>
                    <div className={quizItemStyles['icon-level-text']}>
                        <b style={{ marginRight: '5px' }}>{scoreIcon}</b>
                        <b>
                            {props.quiz.level}. {props.quiz.name}
                        </b>
                    </div>

                    <QuizDescriptionChip quizDescriptionType = {props.quiz.description}/>
                </div>

                <MetricIcons>
                    <ul className={styles['metric-icons-ul']}>
                        <li className={styles['metric-icons-li']}>
                            <AssignmentIcon sx={{ color: 'gray', marginRight: '3px' }} />
                            {highScore?.score ? (
                                // eslint-disable-next-line no-unsafe-optional-chaining
                                <p style={{ color: 'rgb(0, 0, 141)' }}>{(highScore?.score).toFixed(0)}%</p>
                            ) : (
                                <p style={{ color: 'rgb(0, 0, 141)' }}>0%</p>
                            )}
                        </li>
                        <li className={styles['metric-icons-li']}>
                            <AccessTimeIcon sx={{ color: 'gray', marginRight: '3px' }} />
                            {highScore?.secondsToComplete ? (
                                <p style={{ color: 'rgb(0, 0, 141)' }}>
                                    {(highScore?.secondsToComplete / props.quiz.length).toFixed(2)}s/
                                    <b style={{ fontSize: '17px' }}>♩</b>
                                </p>
                            ) : (
                                <p style={{ color: 'rgb(0, 0, 141)' }}>n/a</p>
                            )}
                        </li>
                        <li className={styles['metric-icons-li']}>
                            <RepeatIcon sx={{ color: 'gray', marginRight: '3px' }} />
                            <p style={{ color: 'rgb(0, 0, 141)' }}>{numberOfCompletedQuizAttemptsForQuiz}</p>
                        </li>
                    </ul>
                </MetricIcons>

                {/*{showDetails && (*/}
                {/*    <>*/}
                {/*        /!*<div style={{ marginTop: '10px' }}>{props.quiz.description}</div>*!/*/}
                {/*    /!*    <Button*!/*/}
                {/*    /!*        variant="contained"*!/*/}
                {/*    /!*        style={{ backgroundColor: 'rgb(135, 57, 255)' }}*!/*/}
                {/*    /!*        sx={{ width: '100%', marginTop: '20px' }}*!/*/}
                {/*    /!*        // onClick={handlePlayQuizClick}*!/*/}
                {/*    /!*    >*!/*/}
                {/*    /!*        Play*!/*/}
                {/*    /!*    </Button>*!/*/}
                {/*    /!*</>*!/*/}
                {/*)}*/}
            </Card>
        </Container>
    );
};

export default QuizItem;
