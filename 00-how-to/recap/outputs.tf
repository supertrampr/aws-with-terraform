output "read_file" {
  description = "Command on how to read file."
  value       = <<EOT
The file has been created, read it by running:

  cat ${path.root}/${local.file_name_to_upper}

EOT
}