import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/dist/query/react';
import { Quiz } from '../../models/Quiz';

export const quizApi = createApi({
    reducerPath: 'quizApi',
    baseQuery: fetchBaseQuery({ baseUrl: 'http://localhost:8000' }),
    endpoints: (builder) => ({
        getQuizzes: builder.query({
            query: () => '/quizzes',
        }),
        getPitchesByQuizId: builder.query({
            query: (quizId: number) => `/quizzes/${quizId}/pitches`,
        }),
        getQuizAttemptCollectionByUser: builder.query({
            query: (userId: string) => `/user/${userId}/quizAttempt`,
        }),
        createQuizAttempt: builder.mutation({
            query: ({ userId, quizId }) => ({
                url: `/user/${userId}/quizAttempt?quizId=${quizId}`,
                method: 'POST',
            }),
        }),
        patchQuizAttempt: builder.mutation({
            query: ({ userId, quizAttemptId, completedIn }) => ({
                url: `/user/${userId}/quizAttempt/${quizAttemptId}?secondsToComplete=${completedIn}`,
                method: 'PATCH',
            }),
        }),
        createQuizPitchAttempt: builder.mutation({
            query: ({ userId, body }) => ({
                url: `/user/${userId}/quizPitchAttempt`,
                method: 'POST',
                body: body,
            }),
        }),
        createUser: builder.mutation({
            query: (body) => ({
                url: `/user`,
                method: 'POST',
                body: JSON.stringify({
                    firebaseUid: body.firebaseUid,
                    isAnonymous: body.isAnonymous,
                    email: body.email,
                    displayName: body.displayName,
                }),
            }),
        }),
    }),
});

export const {
    useGetQuizzesQuery,
    useGetPitchesByQuizIdQuery,
    useCreateQuizAttemptMutation,
    useCreateQuizPitchAttemptMutation,
    useGetQuizAttemptCollectionByUserQuery,
    usePatchQuizAttemptMutation,
    useCreateUserMutation,
} = quizApi;
