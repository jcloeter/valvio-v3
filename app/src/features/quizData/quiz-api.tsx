import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/dist/query/react';

let apiUrl: string|undefined = process.env.REACT_APP_DEV_API_URL || undefined;

try{
    if (process.env.NODE_ENV === "production"){
        apiUrl = process.env.REACT_APP_PROD_API_URL || undefined;
        if (!apiUrl){
            throw new Error("Must define an api url in production")
        }
    }
    if (process.env.NODE_ENV === "production" && apiUrl){
        throw new Error("Must define an api url in development")
    }
}catch(e){
    console.error(e);
}


export const quizApi = createApi({
    reducerPath: 'quizApi',
    baseQuery: fetchBaseQuery({ baseUrl: apiUrl }),
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
        getUser: builder.query({
            query: ({userId}) => ({
                url: `/user/${userId}`,
                method: 'GET'
            })
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
    useGetUserQuery,
} = quizApi;
