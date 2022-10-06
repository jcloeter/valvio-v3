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

const MetricsCard = () => {
    const quizSlice = useAppSelector(state => state.quizAttemptSlice);
    const currentPitchIndex = useSelector<RootState, number>((state) => state.quizAttemptSlice.currentPitchIndex);




    //We need to display:
    //Level Name and Number
    //If transposition include transpo instructions
    //Current Score = inCorrect *
    //Index+1 / quizLength
    // Index / startTime - Date.now()
    // Instructions if index === 0 AND incorrect && correct guesses === 0;
    //  else: if attempt isIncorrect display X Try Again
    //  esle: if attempt isCorrect show pitch[index-1]image with (Checkmark) Gorrect! ${pitchname} is ${position}

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
            <>
                <section>
                    <p> <b>Level {quizSlice.quizLevel}.</b> {quizSlice.quizName}</p>
                    <p> {quizSlice.isTransposition ?
                        <><b>Transposition: </b>{quizSlice.transpositionDescription}</> :
                        <><b>Mode:</b> Pitch Recognition</> }</p>
                </section>
                <section>
                    <div>
                        <GradingIcon sx={{color : "gray"}}/> {quizSlice.currentScore.toFixed(0)}%
                    </div>
                    <div>
                        <MusicNoteIcon sx={{color : "gray"}}/> {currentPitchIndex}/{quizSlice.quizLength}
                    </div>
                    <div>
                        <AvTimerIcon sx={{color : "gray"}}/> {speed}
                    </div>
                </section>
                <section>
                    {feedback}
                </section>
            </>
        </LightGreyCard>
    );
};

export default MetricsCard;