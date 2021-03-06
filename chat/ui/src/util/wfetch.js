import camelcaseKeys from 'camelcase-keys';
// fetchをwrapして共通化します
// wrapped fetch => wfetch

// https://developer.mozilla.org/ja/docs/Web/API/Fetch_API/Using_Fetch
// TODO: deploy後、https, jsを提供するドメインと、APIを提供するドメインが違う場合のチェック

const base = (path, method, params = {}) => {
  let fetchOption = {
    method: method,
    mode: "cors",
    credentials: "include",
    headers: {
      "Content-Type": "application/json; charset=utf-8",
      'Accept': 'application/json'
    },
  };

  if (method !== "GET") {
    fetchOption.body = JSON.stringify(params);
  }

  const baseUrl = "http://localhost:8080"

  return fetch(baseUrl + path, fetchOption)
    .then(res => res.json())
    .then(json => camelcaseKeys(json))
};

const wfetch = {
  get: (url) => base(url, "GET"),
  post: (url, params) => base(url, "POST", params)
};

export default wfetch;
