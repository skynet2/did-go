# Copyright SecureKey Technologies Inc.
#
# SPDX-License-Identifier: Apache-2.0


# Tool commands (overridable)
DOCKER_CMD ?= docker

GOBIN_PATH=$(abspath .)/build/bin
MOCKGEN=$(GOBIN_PATH)/mockgen
GOMOCKS=pkg/internal/gomocks
MOCK_VERSION 	?=v1.7.0-rc.1

.PHONY: all
all: clean generate checks unit-test

.PHONY: checks
checks: generate license lint

.PHONY: lint
lint:
	@scripts/check_lint.sh

.PHONY: license
license:
	@scripts/check_license.sh

.PHONY: unit-test
unit-test:
	@scripts/check_unit.sh

.PHONY: clean
clean:
	@rm -rf ./.build
	@rm -rf coverage*.out

.PHONY: generate
generate:
	@GOBIN=$(GOBIN_PATH) go install github.com/golang/mock/mockgen@$(MOCK_VERSION)
	@go generate ./...
