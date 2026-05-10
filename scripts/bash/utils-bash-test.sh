# Load BATS helper libraries (paths are relative to this file's location)
# from `scripts/` the project `node_modules` directory is one level up
load '../../node_modules/bats-support/load'
load '../../node_modules/bats-assert/load'

# STUB Infrastructure for testing bash scripts
# ==========================================================================
setup_stubs() {
  STUB_DIR="$(mktemp -d)"
  export PATH="$STUB_DIR:$PATH"
}

teardown_stubs() {
  rm -rf "${STUB_DIR}"
}

# Create a simple stub that returns fixed output
# Usage: stub_cmd <command> <output> [exit_code]
stub_cmd() {
  local cmd=$1
  local output=$2
  local exit_code=${3:-0}

  cat > "${STUB_DIR}/${cmd}" <<EOF
#!/usr/bin/env bash
echo "${output}"
exit ${exit_code}
EOF 
  chmod +x "${STUB_DIR}/${cmd}"
}

# Create a spy that records all calls for later assertion
# Usage: spy_cmd <command> [exit_code]
spy_cmd() {
  local cmd=$1
  local exit_code=${2:-0}

  cat > "${STUB_DIR}/${cmd}" <<'EOF'
#!/usr/bin/env bash
echo "\$@" >> "${STUB_DIR}/${cmd}.calls"
exit ${exit_code}
EOF
  chmod +x "${STUB_DIR}/${cmd}"
}

# Create a stub with different behaviour per call
# Usage: stub_cmd_sequence <command> <output1> <output2> ... [exit_code]
stub_cmd_sequence() {
  local cmd=$1
  shift
  local outputs=("$@")
  local last_index=$(( ${#outputs[@] } - 1 ))

  cat > "${STUB_DIR}/${cmd}" <<'EOF'
#!/usr/bin/env bash
call_count_file="${STUB_DIR}/${cmd}.count"
count=\$(cat "\${call_count_file}" 2>/dev/null || echo 0)
count=\$((count + 1))
echo "\${count}" > "\${call_count_file}"
case "\${count}" in
$(for i in "" "${outputs[@]}"; do
  echo "$((i+1))) echo \"${outputs[$i]}\" ;;"
done)
*) echo "${outputs[$last_index]}" ;;
esac
exit 0
EOF
  chmod +x "${STUB_DIR}/${cmd}"
}

# ASSERTION helpers
# ==========================================================================

# Assert that a command was called at least once
assert_cmd_called() {
  local cmd=$1
  assert [ -f "${STUB_DIR}/${cmd}.calls" ]
}

# Assert command was never called
assert_cmd_not_called() {
  local cmd=$1
  assert [ ! -f "${STUB_DIR}/${cmd}.calls" ]
}

assert_cmd_called_with() {
  local cmd=$1
  local expected_count=$2
  local actual_count
  actual_count=$(wc -l < "${STUB_DIR}/${cmd}.calls" 2>/dev/null || echo 0)
  assert [ "$actual_count" -eq "$expected_count" ]
}
