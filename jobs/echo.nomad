job "echo" {
  datacenters = ["dc1"]
  type = "service"

  group "apis" {
    count = 3

    task "echo" {
      driver = "docker"

      config {
        image = "containersol/k8s-deployment-strategies"

        port_map {
          http = 8080
        }
      }

      env {
        VERSION = "1.0.0"
      }

      resources {
        network {
          port "http" { }
        }

        memory = 50
      }

      service {
        name = "echo"
        port = "http"

        tags = [
          "traefik.enable=true",
          "traefik.frontend.rule=Host:api.localhost"
        ]

        check {
          type = "http"
          path = "/"
          interval = "5s"
          timeout = "1s"
        }
      }
    }
  }
}
