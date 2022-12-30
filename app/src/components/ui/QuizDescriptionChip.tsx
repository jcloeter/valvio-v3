import React from 'react';
import EmojiEventsIcon from '@mui/icons-material/EmojiEvents';
import AssessmentIcon from '@mui/icons-material/Assessment';
import MusicNoteIcon from '@mui/icons-material/MusicNote';
import ChangeHistoryIcon from '@mui/icons-material/ChangeHistory';
import {Chip} from "@mui/material";


const QuizDescriptionChip: React.FC<{quizDescriptionType: string}> = (props) => {

    let chip: JSX.Element | null = null;

    switch(props.quizDescriptionType) {
        case "New Note": {
            chip = <Chip label = {"New Note"} variant="filled" color="default" size="small" icon={<MusicNoteIcon />} />;
            break;
        }
        case "Review": {
            chip = <Chip label = {"Review"} variant="filled" color="default" size="small" icon={<AssessmentIcon />} />;
            break;
        }
        case "Scale": {
            chip = <Chip label = {"Scale"} variant="filled" color="primary" size="small" icon={<ChangeHistoryIcon />} />;
            break;
        }
        case "Unit Quiz": {
            chip = <Chip label = {"Unit Quiz"} variant="filled" color="success"  size="small" icon={< EmojiEventsIcon/>} />;
            break;
        }
    }

    return (
        <div>{chip}</div>
    );
};

export default QuizDescriptionChip;