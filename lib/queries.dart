const String fetchCharactersQuery = """
  query GetCharacters {
    characters(page: 1) {
      results {
        id
        name
        status
        species
        image
      }
    }
  }
""";