const friendsQueries = {
  friends: async () => {
    return {
      name: 'Alice',
      friends: [
        {
          name: 'Bob',
          friends: [
            {
              name: 'Joy',
              friends: []
            },
            {
              name: 'John',
              friends: []
            }
          ]
        }
      ]
    }
  }
}

export default friendsQueries
