import React from 'react';

// https://riptutorial.com/reactjs/example/30238/higher-order-component-that-checks-for-authentication

const getCookieByKey = (key:string):string => {
  const pattern = new RegExp("(?:(?:^|.*;s*)" + key + "s*=s*([^;]*).*$)|^.*$/");
  return document.cookie.replace(pattern, "$1");
};

const authed = ():boolean => (
  getCookieByKey("session_id") !== ""
);

const auth = (Component) => {
  const Auth = (props) => {

    // ログインしていたら引数のComponentを返す
    if (authed()) {
      return (
        <Component {...props} />
      );
    }

    // ログインしていなかったら401を表示する
    return (
      <div>
        401 UnAuthorized
      </div>
    );
  }
  return Auth;
};

export default auth;
