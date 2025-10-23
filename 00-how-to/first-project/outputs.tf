output "file_path" {
  description = "Path of file."
  value       = { for key, value in local_file.this : key => "${value.filename}" } # "${path.module}/${local_file.this.filename}"
}