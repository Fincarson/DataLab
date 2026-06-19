import AuthorModel from '../models/authorModel'
import connectPool from '../database'

afterAll(() => {
  connectPool.end()
})

describe('[Author.Model]', () => {
  const schema = {
    userId: expect.any(Number),
    userName: expect.any(String),
    userOrder: expect.any(String),
    createdAt: expect.any(Date),
    updatedAt: expect.any(Date)
  }
  const createdUserName = 'Alice'
  const createdUserOrder = 'Hello Apollo'
  const updatedUserName = 'Bob'
  const updatedUserOrder = 'Hello GraphQL'
  let _userId

  it('Create User', async () => {
    _userId = await AuthorModel.createUser(connectPool, { userName: createdUserName, userOrder: createdUserOrder })
    const author = await AuthorModel.selectUser(connectPool, _userId)

    // Check Data
    expect(author).not.toBeUndefined()

    // Check Content
    expect(author.userName).toEqual(createdUserName)
    expect(author.userOrder).toEqual(createdUserOrder)
  })

  it('Select All User', async () => {
    const users = await AuthorModel.selectAll(connectPool)

    // Check Type
    expect(users).toMatchObject(expect.any(Array))
  })

  it('Select User', async () => {
    const users = await AuthorModel.selectAll(connectPool)
    const user = await AuthorModel.selectUser(connectPool, _userId)
    // Check Data
    expect(users).not.toBeUndefined()

    // Check Type
    expect(user).toMatchObject(schema)

    // Check Content
    expect(user.userName).toEqual(createdUserName)
    expect(user.userOrder).toEqual(createdUserOrder)
  })

  it('Update User', async () => {
    _userId = await AuthorModel.updateUser(connectPool, { userId: _userId }, { userName: updatedUserName, userOrder: updatedUserOrder })
    const user = await AuthorModel.selectUser(connectPool, _userId)
    // Check Data
    expect(user).not.toBeUndefined()

    // Check Content
    expect(user.userName).toEqual(updatedUserName)
    expect(user.userOrder).toEqual(updatedUserOrder)
  })

  it('Delete User', async () => {
    const msg = await AuthorModel.deleteUser(connectPool, _userId)
    const author = await AuthorModel.selectUser(connectPool, _userId)
    // Check Data
    expect(author).toBeUndefined()

    // Check Content
    expect(msg).toEqual(`Delete user ${_userId} successful!`)
  })
})
