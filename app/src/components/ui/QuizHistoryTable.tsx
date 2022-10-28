import * as React from 'react';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import { CircularProgress, Container } from '@mui/material';
import { useGetQuizAttemptCollectionByUserQuery, useGetQuizzesQuery } from '../../features/quizData/quiz-api';
import { useSelector } from 'react-redux';
import { RootState } from '../../features/store';
import AuthSlice from '../../features/authData/authSlice';
import { useEffect, useState } from 'react';
import { QuizAttempt } from '../../models/QuizAttempt';
import { Quiz } from '../../models/Quiz';

function createData(
    level: string,
    name: string,
    score: number | null,
    speed: number | null,
    length: number | null,
    date: string | null,
) {
    return { level, name, score, speed, length, date };
}

interface Row {
    level: string;
    name: string;
    score: number | null;
    speed: number | null;
    length: number | null;
    date: string | null;
}

export default function QuizHistoryTable() {
    const authSlice = useSelector((state: RootState) => state.authSlice);
    console.log(authSlice.uid);
    const {
        data: quizAttemptData,
        isError: isQuizAttemptDataError,
        isLoading: isQuizAttemptDataLoading,
        error,
        refetch,
        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-ignore
    } = useGetQuizAttemptCollectionByUserQuery(authSlice.uid);
    const { data: quizData, isError: isQuizDataError, isLoading: isQuizDataLoading } = useGetQuizzesQuery({});
    const [rows, setRows] = useState<Row[]>([]);
    refetch();

    useEffect(() => {
        if (!quizAttemptData || !quizData) return;

        const quizAttempts = quizAttemptData.quizAttempts;
        const quizzes = quizData.quizzes;

        const completedQuizAttempts = quizAttempts.filter((qa: QuizAttempt) => {
            return qa.completedAt;
        });

        const rowArray: any[] = [];

        completedQuizAttempts.map((qa: QuizAttempt) => {
            const quiz = quizzes.find((quiz: Quiz) => quiz.id == qa.quiz.id);
            // eslint-disable-next-line @typescript-eslint/ban-ts-comment
            // @ts-ignore
            const date = new Date(qa.completedAt).toLocaleDateString('en-US', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
            });
            rowArray.push(
                createData(quiz.level, quiz.name, qa.score, qa.secondsToComplete, quiz.length, date.toString()),
            );
        });

        setRows(rowArray);
    }, [quizAttemptData, quizData]);

    if (isQuizDataLoading || isQuizAttemptDataLoading) {
        return (
            <>
                {' '}
                <br /> <CircularProgress />{' '}
            </>
        );
    }

    if (isQuizDataError || isQuizAttemptDataError) {
        return (
            <>
                {' '}
                <br /> <h3>There was an error fetching your data</h3>{' '}
            </>
        );
    }

    if (rows.length === 0) {
        return (
            <>
                {' '}
                <br /> <h3>No saved data yet. Create an account and complete quizzes to see stored data.</h3>{' '}
            </>
        );
    }

    // eslint-disable-next-line @typescript-eslint/ban-ts-comment
    // @ts-ignore
    return (
        <Container maxWidth="md">
            <br />
            <TableContainer component={Paper}>
                <Table sx={{ minWidth: 650 }} aria-label="simple table">
                    <TableHead>
                        <TableRow>
                            <TableCell>Level</TableCell>
                            <TableCell>Quiz</TableCell>
                            {/*<TableCell align="right">Incorrect</TableCell>*/}
                            <TableCell align="right">Score(%)</TableCell>
                            <TableCell align="right">Speed(s/pitch)</TableCell>
                            <TableCell align="right">Length</TableCell>
                            <TableCell align="right">Date</TableCell>
                        </TableRow>
                    </TableHead>
                    <TableBody>
                        {rows.map((row, i) => (
                            <TableRow key={i} sx={{ '&:last-child td, &:last-child th': { border: 0 } }}>
                                <TableCell component="th" scope="row">
                                    {row.level}
                                </TableCell>
                                <TableCell component="th" scope="row">
                                    {row.name}
                                </TableCell>
                                <TableCell align="right">{row.score}</TableCell>
                                {/*{ !row.speed && row.speed = 1 }*/}
                                {/*{ !row.length && row.length = 1}*/}
                                {!row.speed || !row.length ? (
                                    <TableCell align="right">{error}</TableCell>
                                ) : (
                                    <TableCell align="right">{(row.speed / row.length).toFixed(2)}</TableCell>
                                )}
                                <TableCell align="right">{row.length}</TableCell>
                                {/*<TableCell align="right">{row.incorrect}</TableCell>*/}
                                <TableCell align="right">{row.date}</TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>
            </TableContainer>
        </Container>
    );
}
