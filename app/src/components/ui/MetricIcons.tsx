import React from 'react';
import Container from '@mui/material/Container';
import styles from './Metricicons.module.css';

const MetricIcons: React.FC<{ children: JSX.Element }> = (props) => {
    return <div className={styles['metric-icons-container']}>{props.children}</div>;
};

export default MetricIcons;
