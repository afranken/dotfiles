# Agents: run only make targets listed here. No direct shell commands.
# `make apply` mutates this machine (installs software, writes symlinks) — do not
# run it without human sign-off. See AGENTS.md > Agent Authorization.

.DEFAULT_GOAL := help

.PHONY: help
help: ## Show available commands
	@echo "Usage: make <target>"
	@echo ""
	@echo "Agents: run only the targets listed here — no direct shell commands."
	@echo "        'make apply' changes this machine; get human sign-off first."
	@echo ""
	@echo "Available targets:"
	@awk 'BEGIN {FS=":.*## "}; /^[a-zA-Z0-9_-]+:.*## / { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: lint
lint: ## Lint shell scripts with shellcheck
	shellcheck apply.sh claude/statusline.sh

.PHONY: check
check: lint ## Run all validation (currently: lint)

.PHONY: apply
apply: ## Converge this machine to the declared state (mutates the machine — human sign-off required)
	./apply.sh
