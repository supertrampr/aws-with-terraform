variables {
  suffix = "for-testing"
}

run "nginx_installed" {
  assert {
    condition     = strcontains(data.http.nginx.response_headers["Server"], "nginx")
    error_message = "Nginx is currently running and available."
  }
}

run "website_configured" {
  assert {
    condition     = strcontains(data.http.nginx.response_body, "Terraform course")
    error_message = "Website should display `Terraform course` when visting it."
  }
}