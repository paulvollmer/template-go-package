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

action "test" {
  uses = "myles-systems/actions-golang@v1.12.6"
  needs = ["install"]
  args = "make"
  env = {
    GO111MODULE = "on"
  }
}
