import {createApi, fetchBaseQuery} from "@reduxjs/toolkit/dist/query/react";
import {QuizInterface} from "../../components/ui/QuizList";

export const quizApi = createApi({
    reducerPath: 'quizApi',
    baseQuery: fetchBaseQuery({baseUrl: 'http://localhost:8000'}),
    endpoints: (builder) => ({
        getQuizzes: builder.query({
            query: () => '/quizzes',
            // transformResponse: (response: any) => {return [response.data]},
        }),
        getPitchesByQuizId: builder.query({
            query: (quizId: number) => `/quizzes/${quizId}/pitches`
        }),
        createQuizAttempt: builder.mutation({
            query: ({userId, quizId}) => ({
                url: `/user/${userId}/quizAttempt?quizId=${quizId}`,
                method: 'POST',
            }),
        }),
        createQuizPitchAttempt: builder.mutation({
            query: ({userId, body}) => ({
                url: `/user/${userId}/quizPitchAttempt`,
                method: 'POST',
                body: JSON.stringify({
                    isCorrect: body.isCorrect,
                    userInput: body.userInput,
                    quizPitchId: body.quizPitchId,
                    quizAttemptId: body.quizAttemptId
                })
            })
        }),
    })
});

export const {useGetQuizzesQuery, useGetPitchesByQuizIdQuery, useCreateQuizAttemptMutation, useCreateQuizPitchAttemptMutation} = quizApi;
