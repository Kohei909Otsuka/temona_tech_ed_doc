import React from 'react';
import styled from 'styled-components';
import Search from './Search';
import Menu from './Menu';

const Wrapper = styled.div`
  flex: 3;
  display: flex;
  justify-content: space-between;
  align-items: center;
`;

const RightHeader: React.FC = () => {
  return (
    <Wrapper>
      <Search />
      <Menu />
    </Wrapper>
  );
};

export default RightHeader;
