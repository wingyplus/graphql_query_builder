//// graphql_query_builder module provides functionality to contstruct GraphQL query.

// TODO: support mutation.
// TODO: support subscription.
/// GraphQL query definition.
pub type QueryBuilder {
  Query(operation: String, fields: List(Field))
}

/// GraphQL field.
pub type Field {
  Field(String)
  SubSelection(String, fields: List(Field))
}

/// Convert GraphQL query into a string.
pub fn to_string(qb: QueryBuilder) -> String {
  case qb {
    Query(operation: _operation, fields: fields) ->
      "query{" <> fields_to_string(fields) <> "}"
  }
}

fn fields_to_string(fields: List(Field)) -> String {
  case fields {
    [] -> ""
    [field, ..fields] ->
      case field {
        Field(field) -> field <> " " <> fields_to_string(fields)
        SubSelection(field, fields: sub_fields) ->
          field <> "{" <> fields_to_string(sub_fields) <> "}" <> " " <> fields_to_string(
            fields,
          )
      }
  }
}
