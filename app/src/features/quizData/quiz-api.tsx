import {createApi, fetchBaseQuery} from "@reduxjs/toolkit/dist/query/react";
import {Quiz} from "../../models/Quiz";

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
        getQuizAttemptCollectionByUser: builder.query({
            query: (userId: number) => `/user/${userId}/quizAttempt`,
        }),
        createQuizAttempt: builder.mutation({
            query: ({userId, quizId}) => ({
                url: `/user/${userId}/quizAttempt?quizId=${quizId}`,
                method: 'POST',
            }),
        }),
        patchQuizAttempt: builder.mutation({
            query: ({userId, quizAttemptId, completedIn}) => ({
                url: `/user/${userId}/quizAttempt/${quizAttemptId}?secondsToComplete=${completedIn}`,
                method: 'PATCH',
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

export const {
    useGetQuizzesQuery,
    useGetPitchesByQuizIdQuery,
    useCreateQuizAttemptMutation,
    useCreateQuizPitchAttemptMutation,
    useGetQuizAttemptCollectionByUserQuery,
    usePatchQuizAttemptMutation,
} = quizApi;
