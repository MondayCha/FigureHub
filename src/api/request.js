import axios from 'axios'

var axios_service = {
    base_url: "http://localhost:2333",
    instanace: null,
    init() {
        const axiosInstance = axios.create({
            withCredentials: true
        });
        axiosInstance.interceptors.request.use(config => {
            const token = localStorage.getItem('token') //从 localstorage 中获取token
            if (token) {
                config.headers['token'] = token
            }
            return config
        }, function (error) {
            return Promise.reject(error)
        })
        axiosInstance.interceptors.response.use(response => {
            const token = response.data.token
            token && localStorage.setItem('token', token) //将 token 存入 localstorage
            return response.data
        }, function (error) {
            console.log(error)
            try {
                let response = error.response
                const token = response.data.token
                token && localStorage.setItem('token', token) //将 token 存入 localstorage
                return response.data
            } catch (e) {
                console.error(e);
            }
            return Promise.reject(error)
        })
        this.instanace = axiosInstance;
    },
    post_with_params(store, post_url, params) {
        if (!this.instanace) {
            this.init();
        }
        console.log(post_url, params)
        return this.instanace.post(post_url, null, {params: params,});
    },
    post_with_file(store, post_url, params, file) {
        if (!this.instanace) {
            this.init();
        }
        let formData = new FormData();
        formData.append('fileName', file);
        return this.instanace.post(post_url, formData, {params: params,});
    },
    register(store, post_url, params, avatar_file) {
        if (!this.instanace) {
            this.init();
        }
        let formData = new FormData();
        formData.append('fileName', avatar_file);
        return this.instanace.post("/user/register", formData, {params: params,});
    },
    put_with_params(store, put_url, params) {
        if (!this.instanace) {
            this.init();
        }
        console.log(put_url, params)
        return this.instanace.put(put_url, null, {params: params,});
    },
    put(put_url, params) {
        if (!this.instanace) {
            this.init();
        }
        console.log(put_url, params)
        return this.instanace.put(put_url, null, {params: params,});
    },
    get(get_url, get_params) {
        if (!this.instanace) {
            this.init();
        }
        console.log(get_url, get_params)
        return this.instanace.get(get_url, {params: get_params,});
    },
    get_with_params(store, get_url, get_params) {
        if (!this.instanace) {
            this.init();
        }
        console.log(get_url, get_params)
        return this.instanace.get(get_url, {params: get_params,});
    },
    delete_with_params(store, del_url, delete_params) {
        if (!this.instanace) {
            this.init();
        }
        console.log(del_url, delete_params)
        return this.instanace.delete(del_url, {params: delete_params,});
    },

}

export default axios_service
