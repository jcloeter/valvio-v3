import React from 'react';
import {Card, Container} from "@mui/material";

//Each QuizItem needs:
// CompletionIcon Level Number: Description
// Highscore Highspeed PlayButton

const QuizItem = () => {
    return (
        <Container maxWidth="sm">
            <Card elevation = {0}
                  sx={{
                      margin : "10px",
                      backgroundColor: "#F8F8F8",
                      paddingTop: "25px",
                      paddingBottom: "25px"
                      // backgroundColor: "red",

                  }}>
                <div>Top LEVEL</div>
                <div>Bottom Level</div>
            </Card>
        </Container>
    );
};

export default QuizItem;