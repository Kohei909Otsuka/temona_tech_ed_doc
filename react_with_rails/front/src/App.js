import React, { useState, useEffect } from 'react';

const App = () => {
  const [users, setUsers] = useState([
     // { id: 1, name: "Iron Man", mail: "test1@example.com" },
     // { id: 2, name: "Captain America", mail: "test2@example.com" },
     // { id: 3, name: "Black Widow", mail: "test3@example.com" },
     // { id: 4, name: "Hulk", mail: "test4@example.com" },
     // { id: 5, name: "HawkEye", mail: "test5@example.com" },
     // { id: 6, name: "Thor", mail: "test6@example.com" },
     // { id: 7, name: "Thanos", mail: "test7@example.com" },
     // { id: 8, name: "Batman", mail: "test8@example.com" },
     // { id: 9, name: "Spiderman", mail: "test9@example.com" },
     // { id: 10, name: "Superman", mail: "test10@example.com" },
  ]);

  useEffect(() =>{
    fetch(`${process.env.REACT_APP_API_URL}/users`)
      .then(res => (res.json()))
      .then(json => {
        setUsers(json.map(u => ({id: u.id, name: u.name, mail: u.mail})));
      })
  }, []);

  return (
    <div>
      <ul>
        { users.map(u => (<li key={u.id}>{u.name}, {u.mail}</li>)) }
      </ul>
    </div>
  )
}

export default App;
