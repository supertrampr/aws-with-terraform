locals {
  json_decoded_response_body = jsondecode(data.http.this.response_body)
}