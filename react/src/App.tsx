import React from 'react';
import styled from 'styled-components';
import Header from './Header';
import Rooms from './Rooms';
import ChatRoom from './ChatRoom';

const RootWrapper = styled.div`
  display: flex;
  height: calc(100vh - 50px);
`;

const App: React.FC = () => {
  return (
    <div>
      <Header />
      <RootWrapper>
        <Rooms />
        <ChatRoom />
      </RootWrapper>
    </div>
  );
};

export default App;
