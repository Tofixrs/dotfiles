let
  tofix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGODy2YjL1vmELOYHzbXrHXzyssBjq6CiMxwvpE6pZsf";
  lapfix = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA+x3GXBxazJh+FyUgra++g9wjK1WmUwb6ikQbwAL0KI";
in {
  "ags-config.age".publicKeys = [tofix lapfix];
}
