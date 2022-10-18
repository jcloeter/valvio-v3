import React from 'react';
import PrimaryCard from "../components/layout/PrimaryCard";
import Button from "@mui/material/Button";
import {getAuth, signOut} from 'firebase/auth';
import {useSelector} from "react-redux";
import {User} from "../models/User";
import {RootState} from "../features/store";
import {Avatar} from "@mui/material";

const ProfilePage = () => {
    const authSlice = useSelector((state: RootState) => state.authSlice);

    const auth = getAuth();
    const handleLogOut = async ()=>{
        console.log("singing out from firebase now")
        await signOut(auth);
    }

    return (
        <PrimaryCard>
            <h1>Welcome {authSlice.displayName}!</h1>
            {authSlice.photoUrl && <img alt="user_avatar" style = {{maxHeight: '100px', borderRadius: '50%' }} src={authSlice.photoUrl || ''}/>}
            {/*<img alt="user_avatar" style = {{maxHeight: '100px', borderRadius: '50%' }} src={authSlice.photoUrl || ''}/>*/}
            {/*<Avatar alt="user_avatar" src={authSlice.photoUrl || ''} sx={{ width: 100, height: 100 }}/>*/}
            {/*<p>According to redux you are {authSlice.isAuthenticated ? "signed in" : "signed out"}</p>*/}
            <br/>
            <p>Username: {(authSlice.displayName || "anonymous")}</p>
            <br/>
            <p>Email: {(authSlice.email) || "no email"}</p>
            <Button variant = "contained" onClick={handleLogOut}>Logout</Button>
        </PrimaryCard>
    );
};

export default ProfilePage;