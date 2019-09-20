import React, { useState, useEffect} from 'react';
import styled from 'styled-components';
import Room from './Room';
import wfetch from './util/wfetch';

const Wrapper = styled.div`
  background-color: #f2d3d3;
  flex: 1;
`;

const fetchRooms = () => {
  return wfetch.get("/rooms")
    .then(json => json.data.map(d => d.attributes))
};

// TODO: unread API側が未実装
const Rooms: React.FC = () => {
  const  [rooms, setRooms] = useState([])

  useEffect(() => {
    fetchRooms()
      .then(rooms => setRooms(rooms))
  },[])

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
