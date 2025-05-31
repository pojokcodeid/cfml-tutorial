import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import secureLocalStorage from "react-secure-storage";
import Home from "../components/Home.jsx";
import Login from "../components/Login.jsx";
import { ToastContainer } from "react-toastify";
import Register from "../components/user/Register.jsx";
import Logout from "../components/Logout.jsx";
import Profile from "../components/user/Profile.jsx";

const RouteNavigation = () => {
    const user = secureLocalStorage.getItem("user");
    const buildNav = () => {
        if (user) {
            return (
                <>
                    <BrowserRouter>
                        <Routes>
                            <Route path="/" element={<Home />} />
                            <Route path="/logout" element={<Logout />} />
                            <Route path="/profile" element={<Profile />} />
                        </Routes>
                    </BrowserRouter>
                </>
            );
        } else {
            return (
                <>
                    <BrowserRouter>
                        <Routes>
                            <Route path="*" element={<Login />} />
                            <Route path="/register" element={<Register />} />
                            <Route path="/login" element={<Login />} />
                        </Routes>
                    </BrowserRouter>
                </>
            );
        }
    };
    return (
        <>
            {buildNav()}
            <ToastContainer />
        </>
    );
};

export default RouteNavigation;
