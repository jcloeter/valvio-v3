import React from 'react';
import CancelIcon from '@mui/icons-material/Cancel';
import IconAndTextWrapper from '../../pages/IconAndTextWrapper';

const WrongAnswerFeedback = () => {
    return (
        <IconAndTextWrapper>
            <>
                <CancelIcon style={{ color: 'red' }} />
                <p>Wrong Answer!</p>
            </>
        </IconAndTextWrapper>
    );
};

export default WrongAnswerFeedback;
