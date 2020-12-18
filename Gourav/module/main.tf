resource "null_resource" "first_run_timer" {
  triggers = {
    #leave this hardcoded, so it only happens on 1st run
    build_number = 1
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "sleep 90"
  }
}
