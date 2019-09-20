import React from 'react';
import styled from 'styled-components';

// https://saruwakakun.com/html-css/reference/speech-bubble
const Wrapper = styled.div`
  margin-top: 20px;
  padding: 5px 10px;
  min-width: 120px;
  max-width: 50%;
  background: #e0edff;
  border-radius: 10px;
  align-self: ${props => props.mine ? "flex-start" : "flex-end"};
`;

const Msg = (props) => {
  const {content, mine} = props;

  return (
    <Wrapper mine={mine}>
      <div>{content}</div>
    </Wrapper>
  );
};

export default Msg;
