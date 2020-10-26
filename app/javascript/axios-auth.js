import axios from 'axios';

const instance = axios.create({});

instance.interceptors.request.use(
    config => {
        config.headers =  {
            'Content-Type' : 'application/json',
            "access-token" : localStorage.getItem("access-token"),
            uid : localStorage.getItem("uid"),
            client : localStorage.getItem("client")
        }
        return config;
    },
    error => {
        return Promise.reject(error);
    }
);

export default instance;
