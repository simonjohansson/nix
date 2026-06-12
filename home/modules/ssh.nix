{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "~/.orbstack/ssh/config" ];
    settings."*" = {
      IdentityFile = [ "~/.ssh/id_ed25519" ];
      UseKeychain = "yes";
    };
  };
}
