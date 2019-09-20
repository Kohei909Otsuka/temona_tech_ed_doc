import React, { useState } from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 10px 0 10px;
  background: ${props => props.focus ? "red" : ""};
`;

const MaxNameLength:number = 20;

const Room = (props: Props) => {
  const { name, unread } = props;
  const [focus, setFocus] = useState(false);

  let displayName:string = name;
  if (name.length >= MaxNameLength) {
    displayName = name.substring(0, MaxNameLength - 1);
  }

  let displayUnread:string = unread.toString();
  if (unread === 0) {
    displayUnread = '';
  }

  return (
    <Wrapper
      onMouseOver={() => setFocus(true)}
      onMouseOut={() => setFocus(false)}
      focus={focus}
    >
      <div>{displayName}</div>
      <div>{displayUnread}</div>
    </Wrapper>
  );
};

export default Room;
