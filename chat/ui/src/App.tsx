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

const App: React.FC = () => {
  const routeResult = useRoutes(routes);
  return routeResult;
};

export default App;
