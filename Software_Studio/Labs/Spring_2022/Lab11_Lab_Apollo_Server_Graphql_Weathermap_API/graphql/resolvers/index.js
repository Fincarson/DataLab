import { versionQueries } from './version'
import { weatherQueries } from './weather'
import { friendsQueries } from './friends'
import { helloQueries } from './hello'

const resolvers = {
  Query: {
    ...versionQueries,
    ...weatherQueries,
    ...friendsQueries,
    ...helloQueries
  }
}

export default resolvers
