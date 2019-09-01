import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  background-color: #8bd1e0;
  height: 50px;
`;

const Header: React.FC = () => {
  return (
    <Wrapper>
      <div>header</div>
    </Wrapper>
  );
};

export default Header;
