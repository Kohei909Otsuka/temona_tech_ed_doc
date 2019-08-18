import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  background-color: #ecf7c1;
  flex: 3;
`;

const ChatRoom: React.FC = () => {
  return (
    <Wrapper>
      <div>chat room</div>
    </Wrapper>
  );
};

export default ChatRoom;
