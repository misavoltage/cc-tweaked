{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  packages = with pkgs; [ ];

  # https://devenv.sh/languages/
  languages.lua.enable = true;
}
