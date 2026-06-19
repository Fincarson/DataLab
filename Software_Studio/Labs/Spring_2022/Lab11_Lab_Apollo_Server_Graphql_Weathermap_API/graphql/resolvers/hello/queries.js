const helloQueries = {
  hello: async (_, args) => {
    switch (args.number) {
      case 0:
        return 'world!'
      case 1:
        return 'javascript'
      default:
        return `No.${args.number}`
    }
  }
}

export default helloQueries
