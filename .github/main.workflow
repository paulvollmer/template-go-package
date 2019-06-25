workflow "CI" {
  on = "push"
  resolves = ["test"]
}

action "install" {
  uses = "myles-systems/actions-golang@v1.12.6"
  args = "go get -v"
  env = {
    GO111MODULE = "on"
  }
}

action "lint" {
  uses = "myles-systems/actions-golang@v1.12.6"
  needs = ["install"]
  args = "make install-lint && make lint"
  env = {
    GO111MODULE = "on"
  }
}

action "test" {
  uses = "myles-systems/actions-golang@v1.12.6"
  needs = ["lint"]
  args = "make"
  env = {
    GO111MODULE = "on"
  }
}
