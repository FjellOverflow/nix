let
  vm = "ssh-ed25519 PLACEHOLDER_VM_HOST_PUBKEY";
  hosts = [ vm ];
in {
  "ssh-private-key.age".publicKeys = hosts;
}
