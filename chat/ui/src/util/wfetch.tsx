// fetchをwrapして共通化します
// wrapped fetch => wfetch

// https://developer.mozilla.org/ja/docs/Web/API/Fetch_API/Using_Fetch
// TODO: deploy後、https, jsを提供するドメインと、APIを提供するドメインが違う場合のチェック

type HttpMethod = "GET" | "POST";
const base = (path:string, method:HttpMethod, params:Object = {}) => {
  const fetchOption:RequestInit = {
    method: method,
    mode: "cors",
    credentials: "include",
    headers: {
      "Content-Type": "application/json; charset=utf-8",
      'Accept': 'application/json'
    },
    body: JSON.stringify(params),
  };

  const baseUrl = "http://localhost:8080"

  return fetch(baseUrl + path, fetchOption)
    .then(res => res.json())
};

const wfetch = {
  get: (url:string) => base(url, "GET"),
  post: (url:string, params:Object) => base(url, "POST", params)
};

export default wfetch;
