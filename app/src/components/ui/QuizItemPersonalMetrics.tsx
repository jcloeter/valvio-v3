import React, { useEffect } from 'react';
import { LinearProgress } from '@mui/material';
import { QuizAttempt } from '../../models/QuizAttempt';

const QuizItemPersonalMetrics: React.FC<{ highScore: QuizAttempt | null }> = (props) => {
    return (
        <div>
            {props.highScore ? <h6>HIGHSCORE</h6> : <h6>None</h6>}
            <i>Loading Personal Metrics</i>
            <LinearProgress color="inherit" />
        </div>
    );
};

export default QuizItemPersonalMetrics;
