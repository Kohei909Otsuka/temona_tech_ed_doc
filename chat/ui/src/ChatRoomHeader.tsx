import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  background-color: #ddedbe;
  flex: 1;
`;

const ChatRoomHeader: React.FC = () => {
  return (
    <Wrapper>
      <div>chat room header</div>
    </Wrapper>
  )
};

export default ChatRoomHeader;
