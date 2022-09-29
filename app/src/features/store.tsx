import { configureStore, ThunkAction, Action } from '@reduxjs/toolkit';
import quizSliceReducer from "../features/quizData/quizSlice";
import {quizApi} from "./quizData/quiz-api";

export const store = configureStore({
    reducer: {
        quizAttemptSlice: quizSliceReducer,
        [quizApi.reducerPath] : quizApi.reducer
    },
    middleware: getDefaultMiddleware =>
        getDefaultMiddleware().concat(quizApi.middleware)
});

export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;
export type AppThunk<ReturnType = void> = ThunkAction<
    ReturnType,
    RootState,
    unknown,
    Action<string>
    >;