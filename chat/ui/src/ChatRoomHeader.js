import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  background-color: #ddedbe;
  flex: 1;
  padding: 0 10px 0 10px;
  display: flex;
  justify-content: center;
  align-items: center;
`;

const ChatRoomHeader = (props) => {
  const { name } = props;
  return (
    <Wrapper>
      <div>{name}</div>
    </Wrapper>
  )
};

export default ChatRoomHeader;
