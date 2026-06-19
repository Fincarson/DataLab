import { createTestClient } from 'apollo-server-testing'
import { gql } from 'apollo-server'
import graphqlServer from '../graphql'

const GET_TYPE = gql`
query Query {
  typeInt
  typeString
  typeBool
  typeFloat
}
`

describe('[Queries.Type]', () => {
  it('Get Type', async () => {
    const { query } = createTestClient(graphqlServer)

    const res = await query({
      query: GET_TYPE
    })

    expect(res.data.typeInt).toBe(1)
    expect(res.data.typeString).toBe('hello')
    expect(res.data.typeBool).toBe(true)
    expect(res.data.typeFloat).toBe(1.1)
  })
})
