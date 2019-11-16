# Data for a [GraphQL directive](https://graphql.github.io/graphql-spec/draft/#sec-Language.Directives).
#
# See the [GraphQL spec](https://graphql.github.io/graphql-spec/draft/#sec-Type-System.Directives) or [Apollo's docs](https://www.apollographql.com/docs/graphql-tools/schema-directives/) for reference.
class Directive
  # @return [String]
  attr_reader :name
  # @return [String,nil]
  attr_accessor :description
  # Objects on which the directive can be used.
  # @return [Array<String>]
  attr_accessor :locations
  # @return [Array<Gql::Models::Argument>]
  attr_accessor :args
end
