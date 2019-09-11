import React, { useState } from 'react';
import wfetch from './util/wfetch';

const submit = (email: string, password: string) => {
  wfetch.post("/login", {email, password})
    .then(json => console.log(json))
};

const Login: React.FC = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  return (
    <div>
      <input
        type="text"
        placeholder="Email"
        onChange={(e) => setEmail(e.target.value)}
        value={email}
      />
      <input
        type="password"
        placeholder="Password"
        onChange={(e) => setPassword(e.target.value)}
        value={password}
      />
      <button
        onClick={() => submit(email, password)}
      >
        ログイン
      </button>
    </div>
  );
};

export default Login
