resource "null_resource" "Creation_of_documentation" {
  provisioner "local-exec" {
    command = "terraform-docs markdown ${abspath(path.module)} | tee ${abspath(path.module)}/README.md"
  }
  triggers = {
      always_run = "${timestamp()}"
    }
}
