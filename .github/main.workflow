workflow "CI" {
  on = "push"
  resolves = ["test"]
}

action "install" {
  uses = "myles-systems/actions-golang@master"
  args = "go get -v"
  env = {
    GO111MODULE = "on"
  }
}

action "lint" {
  uses = "myles-systems/actions-golang@master"
  needs = ["install"]
  args = "make lint"
  env = {
    GO111MODULE = "on"
  }
}

action "test" {
  uses = "myles-systems/actions-golang@master"
  needs = ["lint"]
  args = "make"
  env = {
    GO111MODULE = "on"
  }
}
