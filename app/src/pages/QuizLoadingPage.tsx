import React, {useEffect, useState} from 'react';
import {useParams} from "react-router";
import {useNavigate} from "react-router-dom";
import {useCreateQuizAttemptMutation, useGetPitchesByQuizIdQuery} from "../features/quizData/quiz-api";
import {Box, CircularProgress, Fab} from "@mui/material";
import CheckCircleOutlineIcon from '@mui/icons-material/CheckCircleOutline';
import {useAppDispatch} from "../features/hooks";
import {setStartTime} from "../features/quizData/quizSlice";


type QuizModeParams = {
    quizId: string
}

const QuizLoadingPage = () => {
    let {quizId} = useParams();
    const dispatch = useAppDispatch();
    const navigate = useNavigate();
    const [timer, setTimer] = useState(1);
    const [showTimer, setShowTimer] = useState(false);
    let interval: any;

    // @ts-ignore
    const {data: pitches, isLoading: arePitchesLoading, isError: arePitchesError} = useGetPitchesByQuizIdQuery(quizId);
    const [ createQuizAttemptMutation,{data, isLoading: isCreateQALoading, isError: isCreateQAError}] = useCreateQuizAttemptMutation();

    useEffect(()=>{
        const result = createQuizAttemptMutation({userId: 7, quizId: quizId}).unwrap().then(fulfilled => console.log(fulfilled)).catch(rejected => console.error(rejected));
    }, [createQuizAttemptMutation, quizId])

    useEffect(()=>{
        if (arePitchesLoading || arePitchesError) {
            return;
        }

        if (isCreateQALoading || isCreateQAError) {
            return;
        }

        interval = setInterval(decreaseTimerAndRedirect, 1000);
        setShowTimer(true);

    }, [arePitchesLoading, arePitchesError, isCreateQAError, isCreateQALoading]);

    useEffect(()=>{
        if (timer === 0) {
            dispatch(setStartTime());
            clearInterval(interval);
            navigate(`/quiz/${quizId}`);
        }
    }, [timer])


    const decreaseTimerAndRedirect=()=>{
        setTimer((count: number)=>{
            count = count -1;
            return count;
        })
    }

    return (
        <div>
            <Box sx={{ m: 1, position: 'relative' }}>
                {arePitchesLoading ? (
                    <CircularProgress
                        size={18}
                        sx={{
                            color: "green",
                            position: 'absolute',
                            top: -6,
                            left: -6,
                            zIndex: 1,

                        }}
                    />
                ): <CheckCircleOutlineIcon sx={{color: "green"}}/>}
                <h3>Loading Pitches</h3>
            </Box>

            <Box sx={{ m: 1, position: 'relative' }}>
                {isCreateQALoading ? (
                    <CircularProgress
                        size={18}
                        sx={{
                            color: "green",
                            position: 'absolute',
                            top: -6,
                            left: -6,
                            zIndex: 1,
                        }}
                    />
                ): <CheckCircleOutlineIcon sx={{color: "green"}}/>}
                <h3>Initializing QuizData</h3>
            </Box>
            {showTimer && `Quiz Starting in ${timer}`}
        </div>
    );
};

export default QuizLoadingPage;


// <Box sx={{ m: 1, position: 'relative' }}>
//     <Fab
//         aria-label="save"
//         color="primary"
//         // sx={buttonSx}
//         // onClick={handleButtonClick}
//     >
//         {/*{success ? <CheckIcon /> : <SaveIcon />}*/}
//     </Fab>
//     {true && (
//         <CircularProgress
//             size={68}
//             sx={{
//                 color: "green",
//                 position: 'absolute',
//                 top: -6,
//                 left: -6,
//                 zIndex: 1,
//             }}
//         />
//     )}
// </Box>