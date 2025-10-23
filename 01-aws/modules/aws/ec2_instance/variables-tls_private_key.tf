variable "tls_private_key_algorithm" {
  description = "Algorithm of tls private key."
  type        = string
  default     = "RSA"

  validation {
    condition = (
      var.tls_private_key_algorithm == "RSA" ||
      var.tls_private_key_algorithm == "ECDSA" ||
      var.tls_private_key_algorithm == "ED25519"
    )
    error_message = "tls_private_key_algorithm must be of values: RSA, ECDSA, ED25519."
  }
}

variable "rsa_bits" {
  description = "RSA bits to generate private key."
  type        = number
  default     = 2048
}

variable "ecdsa_curve" {
  description = "ECDSA curve to generate private key."
  type        = string
  default     = "P224"
}
