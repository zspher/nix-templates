{
  writeTextFile,
  flake,
}:
let
  outputs = (import flake).outputs;
  flakeParams = builtins.listToAttrs (
    builtins.map (x: {
      name = x;
      value = "";
    }) (builtins.attrNames (builtins.functionArgs outputs))
  );
  templates = (outputs flakeParams).templates;
  templateEntries = builtins.map (x: "| [`" + x + "`](./" + x + "/) |") (
    builtins.attrNames templates
  );
in
writeTextFile {
  name = "README.md";
  text = # markdown_inline
    ''
      # templates

      Personal templates to jump-start a project

      to use, replace {name} with the appropriate template

      ```sh
      nix flake init -t github:zspher/nix-templates#{name}
      ```

      ## templates list
      | templates |
      | -- |
      ${(builtins.concatStringsSep "\n" templateEntries)}

      ## dev

      to test the devshell use the ff.

      ```sh
      nix develop . --no-write-lock-file
      ```

      ## interesting templates
      - [the-nix-way/dev-templates](https://github.com/the-nix-way/dev-templates)
    '';
}
