import gleeunit
import gleeunit/should
import graphql_query_builder

pub fn main() {
  gleeunit.main()
}

fn to_string(qb: graphql_query_builder.QueryBuilder) -> String {
  graphql_query_builder.to_string(qb)
}

pub fn empty_query_to_string_test() {
  graphql_query_builder.Query(operation: "", fields: [])
  |> to_string()
  |> should.equal("query{}")
}

pub fn field_to_string_test() {
  graphql_query_builder.Query(
    operation: "",
    fields: [graphql_query_builder.Field("name")],
  )
  |> to_string()
  |> should.equal("query{name }")

  graphql_query_builder.Query(
    operation: "",
    fields: [
      graphql_query_builder.Field("name"),
      graphql_query_builder.Field("lastname"),
    ],
  )
  |> to_string()
  |> should.equal("query{name lastname }")
}

pub fn sub_field_to_string_test() {
  graphql_query_builder.Query(
    operation: "",
    fields: [
      graphql_query_builder.Field("name"),
      graphql_query_builder.SubSelection("address", fields: []),
    ],
  )
  |> to_string()
  |> should.equal("query{name address{} }")

  graphql_query_builder.Query(
    operation: "",
    fields: [
      graphql_query_builder.Field("name"),
      graphql_query_builder.SubSelection(
        "address",
        fields: [
          graphql_query_builder.Field("province"),
          graphql_query_builder.Field("postal_code"),
        ],
      ),
    ],
  )
  |> to_string()
  |> should.equal("query{name address{province postal_code } }")
}
