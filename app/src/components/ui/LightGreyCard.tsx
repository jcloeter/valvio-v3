import React from 'react';
import Card from '@mui/material/Card';

// type Props = {
//     children
// }

const LightGreyCard: React.FC<{ children: JSX.Element }> = (props) => {
    return (
        <Card
            elevation={0}
            sx={{
                margin: '7px',
                backgroundColor: '#F8F8F8',
                paddingTop: '10px',
                paddingBottom: '10px',
            }}
        >
            {props.children}
        </Card>
    );
};

export default LightGreyCard;
