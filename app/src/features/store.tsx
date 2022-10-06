import { configureStore, ThunkAction, Action } from '@reduxjs/toolkit';
import quizSliceReducer from "../features/quizData/quizSlice";
import {quizApi} from "./quizData/quiz-api";
import {authMiddleware} from "./authData/authMiddleware";

export const store = configureStore({
    reducer: {
        quizAttemptSlice: quizSliceReducer,
        [quizApi.reducerPath] : quizApi.reducer
    },
    middleware: getDefaultMiddleware =>
        getDefaultMiddleware().concat(quizApi.middleware).concat(authMiddleware)
});

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
    ReturnType,
    RootState,
    unknown,
    Action<string>
    >;