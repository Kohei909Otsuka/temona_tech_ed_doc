import React from 'react';
import styled from 'styled-components';
import LeftHeader from './LeftHeader';
import RightHeader from './RightHeader';

const Wrapper = styled.div`
  background-color: #8bd1e0;
  height: 50px;
  display: flex;
`;

const Header: React.FC = () => {
  return (
    <Wrapper>
      <LeftHeader />
      <RightHeader />
    </Wrapper>
  );
};

export default Header;
