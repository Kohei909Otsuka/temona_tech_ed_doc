import React from 'react';
import { useRoutes } from 'hookrouter';
import Main from './Main';
import Login from './Login';

const routes = {
  "/": () => <Main />,
  "/login": () => <Login />
};

const App: React.FC = () => {
  const routeResult = useRoutes(routes);
  return routeResult;
};

export default App;
