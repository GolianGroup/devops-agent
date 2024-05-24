variable "IMAGE_PREFIX" {
  default = "registry.glss.ir/jenkins"
}

variable "IMAGE_TAG" {
  default = "1.0.0"
}

variable "PLATFORMS" {
  default = ["linux/amd64", "linux/arm64"]
}

group "default" {
  targets = ["base", "go", "gradle", "maven", "node", "python"]
}

target "base" {
  context    = "./base"
  dockerfile = "Dockerfile"
  tags       = ["${IMAGE_PREFIX}/builder-base:${IMAGE_TAG}"]
  platforms  = PLATFORMS
}

target "go" {
  context = "./go"
  contexts = {
    builder-base = "target:base"
  }
  dockerfile = "Dockerfile"
  tags       = ["${IMAGE_PREFIX}/builder-go:${IMAGE_TAG}"]
  args = {
    GOLANG_VERSION = "1.22.2"
  }
  platforms = PLATFORMS
}

target "gradle" {
  context = "./gradle"
  contexts = {
    builder-base = "target:base"
  }
  dockerfile = "Dockerfile"
  tags       = ["${IMAGE_PREFIX}/builder-gradle:${IMAGE_TAG}"]
  args = {
    JDK_VERSION    = "17"
    GRADLE_VERSION = "6.9.1"
  }
  platforms = PLATFORMS
}

target "maven" {
  context = "./maven"
  contexts = {
    builder-base = "target:base"
  }
  dockerfile = "Dockerfile"
  tags       = ["${IMAGE_PREFIX}/builder-maven:${IMAGE_TAG}"]
  args = {
    JDK_VERSION   = "17"
    MAVEN_VERSION = "3.5.3"
    ANT_VERSION   = "1.10.7"
  }
  platforms = PLATFORMS
}

target "node" {
  context = "./node"
  contexts = {
    builder-base = "target:base"
  }
  dockerfile = "Dockerfile"
  tags       = ["${IMAGE_PREFIX}/builder-node:${IMAGE_TAG}"]
  args = {
    NODE_VERSION = "18.20.2"
    YARN_VERSION = "1.16.0"
  }
  platforms = PLATFORMS
}

target "python" {
  context = "./python"
  contexts = {
    builder-base = "target:base"
  }
  dockerfile = "Dockerfile"
  tags       = ["${IMAGE_PREFIX}/builder-python:${IMAGE_TAG}"]
  args = {
    MINICONDA_VERSION = "4.12.0"
    PYTHON_VERSION    = "3.12"
  }
  platforms = PLATFORMS
}