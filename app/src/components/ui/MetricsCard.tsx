import React from 'react';
import LightGreyCard from "./LightGreyCard";
import {useAppSelector} from "../../features/hooks";
import AvTimerIcon from '@mui/icons-material/AvTimer';
import MusicNoteIcon from '@mui/icons-material/MusicNote';
import GradingIcon from '@mui/icons-material/Grading';
import ValvioDirections from "./ValvioDirections";
import WrongAnswerFeedback from "./WrongAnswerFeedback";
import CorrectAnswerFeedback from "./CorrectAnswerFeedback";
import {useSelector} from "react-redux";
import {RootState} from "../../features/store";
import {Container} from "@mui/material";
import MetricIcons from "./MetricIcons";
import styles from "./Metricicons.module.css";

const MetricsCard = () => {
    const quizSlice = useAppSelector(state => state.quizAttemptSlice);
    const currentPitchIndex = useSelector<RootState, number>((state) => state.quizAttemptSlice.currentPitchIndex);

    let feedback = <ValvioDirections/>;
    if (quizSlice.isUserCorrect && currentPitchIndex > 0) {
        feedback = <CorrectAnswerFeedback/>
    } else if (!quizSlice.isUserCorrect) {
        feedback = <WrongAnswerFeedback/>
    }

    let speed: string | number = "n/a";
    if (currentPitchIndex >0 && quizSlice.startTime) {
        speed = ((Date.now() - quizSlice.startTime)/(currentPitchIndex*1000)).toFixed(2)+'s/pitch';
    }

    return (
        <LightGreyCard>
            <Container>
                <section>
                    <p> <b>Level {quizSlice.quizLevel}.</b> {quizSlice.quizName}</p>
                    <p> {quizSlice.isTransposition ?
                        <><b>Transposition: </b>{quizSlice.transpositionDescription}</> :
                        <><b>Mode:</b> Pitch Recognition</> }</p>
                </section>
                <MetricIcons>
                    <ul className = {styles["metric-icons-ul"]}>
                        <li className = {styles["metric-icons-li"]} >
                            <GradingIcon sx={{color : "gray"}}/>
                            <p className={styles["metric-icons-text"] }>{quizSlice.currentScore.toFixed(0)}%</p>
                        </li>
                        <li className = {styles["metric-icons-li"]} >
                            <MusicNoteIcon sx={{color : "gray"}}/>
                            <p className={styles["metric-icons-text"] }>{currentPitchIndex}/{quizSlice.quizLength}</p>
                        </li>
                        <li className = {styles["metric-icons-li"]} >
                            <AvTimerIcon sx={{color : "gray"}}/>
                            <p className={styles["metric-icons-text"] }>{speed}</p>
                        </li>
                    </ul>
                </MetricIcons>
                <section>
                    {feedback}
                </section>
            </Container>
        </LightGreyCard>
    );
};

export default MetricsCard;