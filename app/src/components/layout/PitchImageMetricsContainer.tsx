import React from 'react';
import styles from './PitchImageMetricsContainer.module.css';
import { Box } from '@mui/material';
import Container from '@mui/material/Container';

const PitchImageMetricsContainer: React.FC<{ children: JSX.Element }> = (props) => {
    return (
        <Container>
            <Box className={styles['pitch-container']}>{props.children}</Box>
        </Container>
    );
};

export default PitchImageMetricsContainer;
