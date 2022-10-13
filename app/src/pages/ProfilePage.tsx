import React from 'react';
import PrimaryCard from "../components/layout/PrimaryCard";
import Button from "@mui/material/Button";
import {getAuth, signOut} from 'firebase/auth';
import {useSelector} from "react-redux";
import {User} from "../models/User";
import {RootState} from "../features/store";

const ProfilePage = () => {
    const authSlice = useSelector((state: RootState) => state.authSlice);

    const auth = getAuth();
    const handleLogOut = async ()=>{
        console.log("singing out from firebase now")
        await signOut(auth);
    }

    return (
        <PrimaryCard>
            <h1>Welcome User!</h1>
            <p>According to redux you are {authSlice.isAuthenticated ? "signed in" : "signed out"}</p>
            <p>Username: {authSlice.displayName}</p>
            <Button variant = "contained" onClick={handleLogOut}>Logout</Button>
        </PrimaryCard>
    );
};

export default ProfilePage;