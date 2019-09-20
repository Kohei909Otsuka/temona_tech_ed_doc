import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
`;

const Menu = () => {
  return (
    <Wrapper>
      <select
        onChange={(e) => console.log("menu selected", e.target.value)}
      >
        <option value="">Menu</option>
        <option value="setting">Setting</option>
        <option value="logout">Logout</option>
      </select>
    </Wrapper>
  )
};

export default Menu;

