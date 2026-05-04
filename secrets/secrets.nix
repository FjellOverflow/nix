let
  vm = "ssh-ed25519 PLACEHOLDER_VM_HOST_PUBKEY";
  allHosts = [ vm ];
in {
  "ssh-private-key.age".publicKeys = allHosts;
}
