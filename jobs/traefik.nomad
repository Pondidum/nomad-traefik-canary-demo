job "traefik" {
  datacenters = ["dc1"]
  type = "service"

  group "loadbalancers" {
    count = 1

    task "traefik" {
      driver = "docker"

      config {
        image = "traefik:1.7.12"

        args = [
          "--api",
          "--consulcatalog",
          "--consulcatalog.endpoint=consul.service.consul:8500",
          "--consulcatalog.frontEndRule=''",
          "--consulcatalog.exposedByDefault=false"
        ]

        port_map {
          http = 80
          ui = 8080
        }
      }

      resources {
        network {
          port "http" { static = 8000 }
          port "ui" { static = 8080 }
        }

        memory = 50
      }

    }
  }
}
