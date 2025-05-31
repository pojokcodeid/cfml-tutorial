import secureLocalStorage from "react-secure-storage";
import { axiosInstance } from "../auth/AxiosConfig.jsx";

const Logout = () => {
    const logout = async () => {
        await axiosInstance.get("/user/logout");
        secureLocalStorage.removeItem("user");
        window.location.href = "/";
    };
    logout();
};

export default Logout;
