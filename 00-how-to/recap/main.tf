module "file" {
  source = "./modules/local_file"

  file_name = "test-1.txt"
  content = templatefile("${path.root}/templates/test.tftpl.hcl", {
    response_headers = data.http.current_ip.response_headers
  })
}