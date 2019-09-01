import React from 'react';
import styled from 'styled-components';

const Input = styled.input`
  font-family: inherit;
  font-size: 100%;
  height: 30px;
  width: 300px;
  display: block;
`;

const Search: React.FC = () => {
  return (
    <div>
      <Input placeholder="Search"/>
    </div>
  );
};

export default Search;

