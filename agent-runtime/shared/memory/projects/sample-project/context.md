# Technical Context: hello-agent

#fact #reference #sample-project

## Language & Toolchain

- Go 1.24.0 (`GOTOOLCHAIN=go1.24.0`)
- Single binary, no external dependencies
- Build: `go build ./...`
- Test: `go test ./...`

## File Map

| File | Purpose |
|------|---------|
| `main.go` | Entry point; prints "Hello from Agent Deck" |
| `README.md` | User docs |

## Environment Requirements

- Go 1.24.0 installed
- `GOTOOLCHAIN=go1.24.0` set in environment

## Known Issues

None yet.
