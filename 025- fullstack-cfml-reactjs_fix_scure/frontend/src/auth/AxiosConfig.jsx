import secureLocalStorage from "react-secure-storage";
import axios from "axios";
axios.defaults.baseURL = import.meta.env.VITE_API_URL;
axios.defaults.timeout = import.meta.env.VITE_API_TIMEOUT;
axios.defaults.withCredentials = true;
axios.defaults.headers.common["Content-Type"] = "application/json";

const api = axios.create();

// refresh logic
const refreshAuthLogic = async () => {
    try {
        const response = await axios.get("/user/refresh");
        secureLocalStorage.setItem("user", response.data.DATA);
        console.log("Simpan token baru berhasil ...");
        return Promise.resolve();
    } catch (error) {
        await axios.get("/user/logout");
        secureLocalStorage.removeItem("user");
        console.log(error.message);
        window.location.href = "/";
        return Promise.reject(error);
    }
};
// Interceptor untuk refresh token ketika access token expired
api.interceptors.response.use(
    (response) => response,
    async (error) => {
        const originalRequest = error.config;
        if (error.response.status === 401 && !originalRequest._retry) {
            originalRequest._retry = true;
            await refreshAuthLogic(originalRequest);
            return api(originalRequest);
        }
        return Promise.reject(error);
    }
);

export const axiosInstance = api;
