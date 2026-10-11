<!-- markdownlint-disable -->

# Hardening Report: aquasecurity--tfsec-pr-commenter-action/v1.3.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **aquasecurity--tfsec-pr-commenter-action/v1.3.1** was hardened automatically. 1 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Rule (b) violation in entrypoint.sh: user-controlled inputs are expanded unquoted in the `tfsec` command on line 57. `${TFSEC_ARGS_OPTION}` is derived directly from `INPUT_TFSEC_ARGS` (the `tfsec_args` action input) and is passed unquoted, allowing shell metacharacters (`;`, `|`, `&`, `$(...)`, etc.) to be interpreted by the shell. Similarly, `${TFSEC_OUT_OPTION}` is derived from `INPUT_TFSEC_FORMATS` and is also unquoted. The offending line is:

```
tfsec --out=${TFSEC_OUT_OPTION} --format="${TFSEC_FORMAT_OPTION}" --soft-fail ${TFSEC_ARGS_OPTION} "${INPUT_WORKING_DIRECTORY}"
```

Both `${TFSEC_OUT_OPTION}` and `${TFSEC_ARGS_OPTION}` must be double-quoted to prevent word-splitting and shell metacharacter injection.

Locations:

- `entrypoint.sh:57`

## Iteration Notes

### Iteration 1

**Fixes applied:** script-injection

**Notes:**

Fixed entrypoint.sh line 57: (1) Added double-quotes around `${TFSEC_OUT_OPTION}` (single filename value). (2) Converted `TFSEC_ARGS_OPTION` from a plain string to a bash array, populated via xargs tokenization (with the required `if [ -n ... ]` guard and NUL-delimited read loop) to safely handle space-separated arguments including quoted sub-commands. The tfsec command now uses `"${TFSEC_ARGS_OPTION[@]}"` to expand each token as a separate, properly-quoted argument. The Dockerfile installs bash so bash array syntax is safe.

### Iteration 2

**Fixes applied:** unpinned-uses

**Notes:**

Pinned the Dockerfile base image from `public.ecr.aws/docker/library/alpine:3.12` to `public.ecr.aws/docker/library/alpine:3.12@sha256:c75ac27b49326926b803b9ed43bf088bc220d22556de1bc5f72d742c91398f69`. The tag is preserved inline for readability while the digest ensures immutability.

