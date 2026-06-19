import { port, env, secret, version, api } from '../config/environment'

describe('[Environment]', () => {
  test('Apollo Server', () => {
    expect(version).not.toEqual('')
    expect(env).not.toEqual('')
    expect(port).not.toEqual('')
    expect(secret).not.toEqual('')
  })

  test('Api', () => {
    expect(api.host).not.toEqual('')
    expect(api.key).not.toEqual('')
  })
})
