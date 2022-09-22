import React from 'react';
import Card from "@mui/material/Card";
import {Container} from "@mui/material";
// import {Card} from "@mui/material";

const PrimaryCard: React.FC<{children: React.ReactNode}> = (props) => {
    return (
        <Container maxWidth="sm" sx={{minHeight : '100vh'}}>
            <Card elevation={3} sx={{
                // minWidth: 275,
                // maxWidth: 500,
                mt: '5%'
            }}>
                {props.children}
            </Card>
        </Container>
    );
};

export default PrimaryCard;