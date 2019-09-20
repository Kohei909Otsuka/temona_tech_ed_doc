import React from 'react';
import styled from 'styled-components';
import ChatRoomHeader from './ChatRoomHeader';
import ChatRoomMsgs from './ChatRoomMsgs';
import ChatRoomText from './ChatRoomText';

const Wrapper = styled.div`
  flex: 3;
  display: flex;
  flex-direction: column;
`;

const room = {
  id: 1,
  name: "哲学科",
  msgs: [
    {
      id: 1,
      content: "昼ごはん行く人!?",
      userId: 1
    },
    {
      id: 2,
      content: "あーごめんmtgあるから無理",
      userId: 2
    },
    {
      id: 3,
      content: "いく!",
      userId: 3
    },
    {
      id: 4,
      content: "ok--じゃあ13:00に下で!",
      userId: 1
    },
    {
      id: 5,
      content: "権限の確認がしたいのだけ\n下記のリンク見れますか?\n https://github.com/typescript-cheatsheets/react-typescript-cheatsheet",
      userId: 4
    },
  ]
};

const ChatRoom = () => {
  return (
    <Wrapper>
      <ChatRoomHeader name={room.name}/>
      <ChatRoomMsgs currentUserId={1} msgs={room.msgs}/>
      <ChatRoomText />
    </Wrapper>
  );
};

export default ChatRoom;
