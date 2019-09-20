import React from 'react';
import { useRoutes } from 'hookrouter';
import Main from './Main';
import Login from './Login';
import auth  from './Auth';

const AuthedMain = auth(Main);

const routes = {
  "/": () => <AuthedMain />,
  "/login": () => <Login />
};

const App = () => {
  const routeResult = useRoutes(routes);
  return routeResult;
};

export default App;
