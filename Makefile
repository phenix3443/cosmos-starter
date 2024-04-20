.PHONY: proto-gen proto-format proto-format-check 
.PHONY: build lint # ci
# .PHONY: test install-go-test-coverage check-coverage


proto-gen:
	buf generate proto

proto-format:
	buf format -w

proto-format-check:
	buf format --diff --exit-code
	
build:
	go build -o build/bin/greeter_server ./cmd/greeter_server/main.go
	go build -o build/bin/greeter_client ./cmd/greeter_client/main.go

lint:
	golangci-lint run --fix

unit_test:
	go test

# ci: proto-format-check build unit_test e2e_init_localchain e2e_test lint proto-gen-check
# 	echo "ci passed"