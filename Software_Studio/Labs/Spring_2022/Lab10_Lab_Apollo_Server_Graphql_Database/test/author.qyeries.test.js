import { createTestClient } from 'apollo-server-testing'
import { gql } from 'apollo-server'
import graphqlServer from '../graphql'

const createdUserName = 'Alice'
const createdUserOrder = 'Hello Apollo'
const updatedUserName = 'Bob'
const updatedUserOrder = ' Hello Graphql'
let _userId

const CREATE_USER = gql`
mutation Mutation($author: AuthorCreateInput!) {
  createAuthor(author: $author) {
    userId
    userName
    userOrder
    createdAt
    updatedAt
  }
}
`

const UPDATE_USER = gql`
mutation Mutation($userId: ID!, $author: AuthorUpdateInput!) {
  updateAuthor(userId: $userId, author: $author) {
    userId
    userName
    userOrder
    createdAt
    updatedAt
  }
}
`

const DELETE_USER = gql`
mutation Mutation($userId: ID!) {
  deleteAuthor(userId: $userId)
}
`

const SELECT_ALL_USERS = gql`
query Query {
  authors {
    userId
    userName
    userOrder
    updatedAt
    createdAt
  }
}
`
const SELECT_USER = gql`
query Query($userId: ID!) {
  author(userId: $userId) {
    userId
    userName
    userOrder
    createdAt
    updatedAt
  }
}
`

describe('[Queries.Author]', () => {
  it('Create user', async () => {
    const input = {
      author: {
        userName: createdUserName,
        userOrder: createdUserOrder
      }
    }
    const { mutate } = createTestClient(graphqlServer)
    const res = await mutate({
      query: CREATE_USER,
      variables: input
    })
    _userId = res.data.createAuthor.userId
    // Check Data
    expect(res.data).not.toBeUndefined()

    // Check Content
    expect(res.data.createAuthor.userName).toEqual(createdUserName)
    expect(res.data.createAuthor.userOrder).toEqual(createdUserOrder)
  })

  it('Update user', async () => {
    const input = {
      author: {
        userName: updatedUserName,
        userOrder: updatedUserOrder
      },
      userId: _userId
    }
    const { mutate } = createTestClient(graphqlServer)
    const res = await mutate({
      query: UPDATE_USER,
      variables: input
    })
    // Check Data
    expect(res.data).not.toBeUndefined()

    // Check Content
    expect(res.data.updateAuthor.userName).toEqual(updatedUserName)
    expect(res.data.updateAuthor.userOrder).toEqual(updatedUserOrder)
  })

  it('Select All users', async () => {
    const { query } = createTestClient(graphqlServer)
    const res = await query({
      query: SELECT_ALL_USERS
    })

    expect(res.data.authors).toMatchObject(expect.any(Array))
  })

  it('Select user', async () => {
    const input = {
      userId: _userId
    }
    const { query } = createTestClient(graphqlServer)
    const res = await query({
      query: SELECT_USER,
      variables: input
    })
    // Check Data
    expect(res.data).not.toBeUndefined()

    // Check Content
    expect(res.data.author.userName).toEqual(updatedUserName)
    expect(res.data.author.userOrder).toEqual(updatedUserOrder)
  })

  it('Delete user', async () => {
    const input = {
      userId: _userId
    }
    const { mutate } = createTestClient(graphqlServer)
    const res = await mutate({
      query: DELETE_USER,
      variables: input
    })

    expect(res.data.deleteAuthor).toEqual(`Delete user ${_userId} successful!`)
  })
})
