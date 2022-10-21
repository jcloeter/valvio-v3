import React from 'react';
import { useAppSelector } from '../../features/hooks';
import { useSelector } from 'react-redux';
import { RootState } from '../../features/store';
import CheckCircleOutlineIcon from '@mui/icons-material/CheckCircleOutline';
import { getAccidentalSignFromName } from '../../helper/getAccidentalSignFromName';
import { createImageUrlFromPitchId } from '../../helper/createImageUrlFromPitchId';
import PitchImageMetricsContainer from '../layout/PitchImageMetricsContainer';
import styles from '../layout/PitchImageMetricsContainer.module.css';
import IconAndTextWrapper from '../../pages/IconAndTextWrapper';

const CorrectAnswerFeedback = () => {
    const quizSlice = useAppSelector((state) => state.quizAttemptSlice);
    const previousPitchIndex = useSelector<RootState, number>((state) => state.quizAttemptSlice.currentPitchIndex) - 1;
    const previousPitch = quizSlice.extendedPitches[previousPitchIndex].originalPitch;
    const previousPitchTransposed = quizSlice.extendedPitches[previousPitchIndex].transposedAnswer;

    let message;

    let pitchImage = (
        <img
            className={styles['pitch-image']}
            style={{ filter: 'grayscale(50%)' }}
            alt="previous-pitch-image"
            src={createImageUrlFromPitchId(previousPitch.id)}
        />
    );
    let transposedPitchImage;

    if (quizSlice.isTransposition && previousPitchTransposed) {
        message = `Correct, ${previousPitch.noteLetter}${getAccidentalSignFromName(previousPitch.accidental)} 
                transposed ${quizSlice.transpositionDescription} is ${
            previousPitchTransposed.noteLetter
        }${getAccidentalSignFromName(previousPitchTransposed.accidental)}, which is played with
                ${previousPitchTransposed.position}`;
        transposedPitchImage = (
            <img
                className={styles['pitch-image']}
                alt="previous-pitch-image-transposed"
                src={createImageUrlFromPitchId(previousPitchTransposed.id)}
            />
        );
    } else {
        message = `Correct, ${previousPitch.noteLetter}${getAccidentalSignFromName(
            previousPitch.accidental,
        )} is played with ${previousPitch.position}`;
    }

    return (
        <div>
            <PitchImageMetricsContainer>
                <>
                    {pitchImage}
                    {transposedPitchImage}
                </>
            </PitchImageMetricsContainer>
            {/*<br/>*/}
            <IconAndTextWrapper>
                <>
                    <CheckCircleOutlineIcon sx={{ color: 'green' }} />
                    <p>{message}</p>
                </>
            </IconAndTextWrapper>
        </div>
    );
};

export default CorrectAnswerFeedback;
