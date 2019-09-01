import React from 'react';
import styled from 'styled-components';
import Room from './Room';

const Wrapper = styled.div`
  background-color: #f2d3d3;
  flex: 1;
`;

const rooms = [
  {
    id: 1,
    name: 'マイチャット',
    unread: 0,
  },
  {
    id: 2,
    name: '哲学科',
    unread: 2,
  },
  {
    id: 3,
    name: 'Github Notification',
    unread: 3,
  },
  {
    id: 4,
    name: 'Circle CI',
    unread: 5,
  },
  {
    id: 5,
    name: "とても長いとても長いとても長いとても長いとても長い",
    unread: 100
  }
];

const Rooms: React.FC = () => {
  return (
    <Wrapper>
      {rooms.map(room => (
        <Room
          key={room.id}
          name={room.name}
          unread={room.unread}
        />
      ))}
    </Wrapper>
  );
};

export default Rooms;
