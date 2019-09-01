import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  background-color: #f2d3d3;
  flex: 1;
`;

const rooms = [
  {
    id: 1,
    name: 'マイチャット'
  },
  {
    id: 2,
    name: '哲学科'
  },
  {
    id: 3,
    name: 'Github Notification'
  },
  {
    id: 4,
    name: 'Circle CI'
  }
];

const Rooms: React.FC = () => {
  return (
    <Wrapper>
      <div>rooms</div>
    </Wrapper>
  );
};

export default Rooms;
