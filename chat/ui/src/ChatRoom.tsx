import React from 'react';
import styled from 'styled-components';
import ChatRoomHeader from './ChatRoomHeader';
import ChatRoomMsg from './ChatRoomMsg';
import ChatRoomText from './ChatRoomText';

const Wrapper = styled.div`
  flex: 3;
  display: flex;
  flex-direction: column;
`;

const ChatRoom: React.FC = () => {
  return (
    <Wrapper>
      <ChatRoomHeader />
      <ChatRoomMsg />
      <ChatRoomText />
    </Wrapper>
  );
};

export default ChatRoom;
