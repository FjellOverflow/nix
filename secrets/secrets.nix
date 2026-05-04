let
  vm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHtvXVR0+vLL+5SDFA4rfQA2siucUb5kHXa8TFMhP5WW";
  hosts = [ vm ];
in {
  "ssh-private-key.age".publicKeys = hosts;
}
