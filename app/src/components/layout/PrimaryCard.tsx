import React, {PropsWithChildren} from 'react';
import Card from "@mui/material/Card";
import {Container} from "@mui/material";
// import {Card} from "@mui/material";



// interface PrimaryCardProps {
//     isLoggedIn: boolean
//     auth: Auth,
//     color: string
// }

const PrimaryCard: React.FC<{children: React.ReactNode}> = (props) => {
// const PrimaryCard = (props: PropsWithChildren<PrimaryCardProps>): JSX.Element => {
    return (
        <Container maxWidth="sm" sx={{minHeight : '100vh'}}>
            <Card elevation={3} sx={{
                paddingTop: "15px",
                paddingBottom: "25px",
                mt: '5%'
            }}>
                {props.children}
            </Card>
        </Container>
    );
};

export default PrimaryCard;