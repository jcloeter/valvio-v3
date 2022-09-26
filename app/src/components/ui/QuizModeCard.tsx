import React from 'react';
import LightGreyCard from "./LightGreyCard";
import Button from "@mui/material/Button";
import ValveGroup from "./ValveGroup";
import styles from "./QuizModeCard.module.css"


const QuizModeCard = () => {
    return (
        <LightGreyCard>
            <>
                <img className = {styles["pitch-img"]} src="https://valvio-data-bucket.s3.us-east-2.amazonaws.com/valvio_pitches/cna5_treble.png" alt="pitch"/>
                <ValveGroup/>
                <Button variant="contained" size ="large" sx={{
                    width: '70%',
                }} >Submit</Button>
            </>
        </LightGreyCard>
    );
};

export default QuizModeCard;