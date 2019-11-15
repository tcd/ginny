# Data for a [GraphQL directive](https://graphql.github.io/graphql-spec/draft/#sec-Language.Directives).
# 
# See the [GraphQL spec](https://graphql.github.io/graphql-spec/draft/#sec-Type-System.Directives) or [Apollo's docs](https://www.apollographql.com/docs/graphql-tools/schema-directives/) for reference.
class Directive
  # @!attribute name [r]
  #   @return [String]
  attr_accessor :name
  # @!attribute description [rw]
  #   @return [String,nil]
  attr_accessor :description
  # @!attribute locations [rw]
  #   Objects on which the directive can be used.
  #   @return [Array<String>]
  attr_accessor :locations
  # @!attribute args [rw]
  #   @return [Array<Gql::Models::Argument>]
  attr_accessor :args
end
