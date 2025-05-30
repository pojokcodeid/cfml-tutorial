import secureLocalStorage from "react-secure-storage";
import axios from "axios";
axios.defaults.baseURL = import.meta.env.VITE_API_URL;
axios.defaults.timeout = import.meta.env.VITE_API_TIMEOUT;
axios.defaults.withCredentials = true;
axios.defaults.headers.common["Content-Type"] = "application/json";

const axiosNoneAuth = axios.create();
const api = axios.create();

api.interceptors.request.use((request) => {
    const token = secureLocalStorage.getItem("acessToken");
    if (token) {
        request.headers["Authorization"] = `Bearer ${token}`;
    }
    return request;
});
// refresh logic
const refreshAuthLogic = async (failedRequest) => {
    try {
        const reqOptions = {
            url: `/user/refresh`,
            method: "GET",
            headers: {
                "Content-Type": "application/json",
            },
        };
        const response = await axios.request(reqOptions);
        secureLocalStorage.setItem("acessToken", response.data.ACCESSTOKEN);
        secureLocalStorage.setItem("user", response.data.DATA);
        console.log("Simpan token baru berhasil ...");
        failedRequest.headers["Authorization"] =
            "Bearer " + response.data.acessToken;
        return Promise.resolve();
    } catch (error) {
        // secureLocalStorage.clear();
        console.log(error.message);
        // window.location.href = "/";
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

export const axiosNoAuth = axiosNoneAuth;
export const axiosInstance = api;
