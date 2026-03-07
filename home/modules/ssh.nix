{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [ "~/.orbstack/ssh/config" ];
    matchBlocks."*" = {
      identityFile = [ "~/.ssh/id_ed25519" ];
      extraOptions = {
        UseKeychain = "yes";
      };
    };
  };
}
