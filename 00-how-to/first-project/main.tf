module "file" {
  source = "./modules/local/file"

  filename = "${path.module}/files/response_body.json"
  file_content = templatefile("${path.module}/templates/response_body.tftpl", {
    ip_address = local.json_decoded_response_body["ip_addr"]
    user_agent = local.json_decoded_response_body["user_agent"]
  })
}


resource "local_file" "conditional" {
  count = var.to_create ? 1 : 0

  filename = "${path.module}/files/additional_file.txt"
  content  = "Variable to_create is ${var.to_create}"
}

## This will implicitly install the provider plugins
## for using the local Terraform provider.
resource "local_file" "this" {
  # count = length(var.courses)
  # for_each = toset(var.courses)
  for_each = var.map_of_courses

  filename = "${path.module}/files/test-${lower(each.key)}.txt"
  content  = "Prima lezione di ${upper(each.value)}."
}

resource "local_file" "template" {
  filename = "${path.module}/files/template-rendered.txt"
  content = templatefile("${path.module}/templates/template.tftpl", {
    response_headers = data.http.this.response_headers
  })

  lifecycle {
    ignore_changes = [
      content
    ]
  }
}
