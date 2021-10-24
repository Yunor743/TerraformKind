terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "k8s_node" {
  name         = "k8s_node:latest"
  keep_locally = true
  build {
    path = "DockerImg"
    tag  = ["k8s_node:latest"]
  }
}

resource "docker_network" "kube_net" {
  name            = "kube_net"
  check_duplicate = true
  ipam_config {
    subnet   = "192.168.0.0/24"
    ip_range = "192.168.0.0/24"
    gateway  = "192.168.0.254"
  }
}

resource "docker_container" "kube-master" {
  name        = "kube-master"
  image       = docker_image.k8s_node.latest
  tty         = true
  hostname    = "kube-master"
  restart     = "unless-stopped"
  privileged  = true
  memory      = 4000
  memory_swap = 4000
  networks_advanced {
    name         = docker_network.kube_net.name
    ipv4_address = "192.168.0.1"
  }
}

resource "docker_container" "kube-worker-1" {
  name        = "kube-worker-1"
  image       = docker_image.k8s_node.latest
  tty         = true
  hostname    = "kube-worker-1"
  restart     = "unless-stopped"
  privileged  = true
  memory      = 4000
  memory_swap = 4000
  networks_advanced {
    name         = docker_network.kube_net.name
    ipv4_address = "192.168.0.2"
  }
}

resource "docker_container" "kube-worker-2" {
  name        = "kube-worker-2"
  image       = docker_image.k8s_node.latest
  tty         = true
  hostname    = "kube-worker-2"
  restart     = "unless-stopped"
  privileged  = true
  memory      = 4000
  memory_swap = 4000
  networks_advanced {
    name         = docker_network.kube_net.name
    ipv4_address = "192.168.0.3"
  }
}

