import React from 'react';
import PrimaryCard from "../components/layout/PrimaryCard";
import Button from "@mui/material/Button";
import {getAuth, signOut} from 'firebase/auth';

const ProfilePage = () => {

    const auth = getAuth();
    const handleLogOut = async ()=>{
        console.log("singing out from firebase now")
        await signOut(auth);
    }

    return (
        <PrimaryCard>
            <h1>Welcome User!</h1>
            <Button onClick={handleLogOut}>Logout</Button>
        </PrimaryCard>
    );
};

export default ProfilePage;