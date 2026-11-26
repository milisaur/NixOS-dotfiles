{pkgs, ...}: let
  jdks = {
    "8" = pkgs.jdk8;
    "21" = pkgs.jdk21;
    "25" = pkgs.jdk25;
  };

  tool = version: jdk: name:
    pkgs.writeShellScriptBin "${name}${version}" ''
      exec ${jdk}/bin/${name} "$@"
    '';

  tools = version: jdk:
    map (tool version jdk) (
      ["java" "javac"]
      ++ pkgs.lib.optional (version != "8") "jshell"
    );

  shell = version: jdk:
    pkgs.writeShellScriptBin "jdk${version}" ''
      export JAVA_HOME="${jdk}"
      export PATH="$JAVA_HOME/bin:$PATH"

      echo "Java ${version} environment"
      java -version

      exec ${pkgs.zsh}/bin/zsh
    '';

  perVersion = f: pkgs.lib.flatten (pkgs.lib.mapAttrsToList f jdks);
in {
  home.packages =
    [pkgs.jdk25]
    ++ perVersion tools
    ++ perVersion (version: jdk: [(shell version jdk)]);

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.jdk25}";
  };
}
