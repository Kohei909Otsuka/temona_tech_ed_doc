import React from 'react';
import styled from 'styled-components';
import Msg from './Msg';

const Wrapper = styled.div`
  background-color: #d5ebab;
  flex: 10;
  padding: 0 10px 0 10px;
  display: flex;
  flex-direction: column;
`;

type Msg = {
  id: number,
  content: string,
  userId: number,
};

type Props = {
  currentUserId: number,
  msgs: Array<Msg>,
};

const ChatRoomMsgs: React.FC<Props> = (props: Props) => {
  const { msgs, currentUserId } = props;
  return (
    <Wrapper>
      {
        msgs.map(msg => (
          <Msg
            key={msg.id}
            content={msg.content}
            mine={currentUserId === msg.userId}
          />
        ))
      }
    </Wrapper>
  )
};

export default ChatRoomMsgs;
