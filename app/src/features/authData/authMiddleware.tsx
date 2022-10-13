import authActions from './authSlice';

export const authMiddleware = (store: any) => (next: any) => (action: any) => {
    // console.log("Auth MIDDLEWARE IS RUNNING");

    // if (authActions.login.match(action)) {
    //     console.log("SAVING TO LOCALSTORAGE")
    // }



    // if (authActions.login.match(action))
    // console.log(a);
    // if (authActions.login.match(action)) {
    //     // Note: localStorage expects a string
    //     localStorage.setItem('isAuthenticated', 'true');
    // } else if (authActions.logout.match(action)) {
    //     localStorage.setItem('isAuthenticated', 'false');
    // }
    return next(action);
};