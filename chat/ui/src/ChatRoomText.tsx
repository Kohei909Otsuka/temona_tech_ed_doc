import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  background-color: #c5e687;
  flex: 2;
`;

const ChatRoomText: React.FC = () => {
  return (
    <Wrapper>
      <div>chat room text</div>
    </Wrapper>
  )
};

export default ChatRoomText;
