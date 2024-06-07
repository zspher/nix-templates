# templates

Personal templates to jump-start a project

```sh
nix flake init -t github:zspher/nix-templates#{name}
```

> replace {name} with the appropriate template

## dev

to test the devshell use the ff.

```sh
nix develop . --no-write-lock-file
```

## templates

each template has the ff.

- [ ] flake config
  - [ ] with lsp, formatter, debugger
- [ ] direnv config
- [ ] buildfiles (_if applicable_)
- [ ] formatter config (_if applicable_)
- [ ] editorconfig
- [ ] gitignore
