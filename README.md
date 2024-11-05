# templates

Personal templates to jump-start a project

to use, replace {name} with the appropriate template

```sh
nix flake init -t github:zspher/nix-templates#{name}
```

## templates list
| templates |
| -- |
| [`c-cpp`](./c-cpp/) |
| [`csharp`](./csharp/) |
| [`default`](./default/) |
| [`latex`](./latex/) |
| [`python`](./python/) |
| [`rust`](./rust/) |

## dev

to test the devshell use the ff.

```sh
nix develop . --no-write-lock-file
```

## interesting templates
- [the-nix-way/dev-templates](https://github.com/the-nix-way/dev-templates)
