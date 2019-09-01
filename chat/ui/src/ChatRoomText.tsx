import React, { useState } from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  background-color: #c5e687;
  flex: 2;
  display: flex;
`;
const TextArea = styled.textarea`
  font-family: inherit;
  font-size: 100%;
  flex: 12;
`;
const Btn = styled.button`
  flex: 1;
`;

const ChatRoomText: React.FC = () => {
  const [text, setText] = useState("");

  return (
    <Wrapper>
      <TextArea
        placeholder="Type Here"
        value={text}
        onChange={e => setText(e.target.value)}
      />
      <Btn
        type="submit"
        onClick={() => {
          console.log("submit!!", text);
          setText("")
        }}
      >
        Send
      </Btn>
    </Wrapper>
  )
};

export default ChatRoomText;
