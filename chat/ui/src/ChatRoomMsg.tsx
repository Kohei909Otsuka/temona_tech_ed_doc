import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  background-color: #d5ebab;
  flex: 10;
`;

const ChatRoomMsg: React.FC = () => {
  return (
    <Wrapper>
      <div>chat room msg</div>
    </Wrapper>
  )
};

export default ChatRoomMsg;
