#!/bin/bash -e

test_run_script() {
    ctx instance runtime-properties test_value $test_value
}

test_run_script_from_url() {
    ctx instance runtime-properties test_value $test_value
}

test_run_script_default_base_dir() {
    ctx instance runtime-properties work_dir $PWD
}

test_run_script_process_config() {
    ctx instance runtime-properties env_value $test_value_env
    ctx instance runtime-properties bash_version $BASH_VERSION
    ctx instance runtime-properties arg1_value $1
    ctx instance runtime-properties arg2_value $2
    ctx instance runtime-properties cwd $PWD
    ctx instance runtime-properties ctx_path $(which ctx)
}

test_run_script_command_prefix() {
    ctx instance runtime-properties sanity sanity
    ctx instance runtime-properties bash_version $BASH_VERSION
}

test_run_script_reuse_existing_ctx_1() {
    ctx instance runtime-properties test_value $test_value
}

test_run_script_reuse_existing_ctx_2() {
    ctx instance runtime-properties test_value $test_value
}

test_run_script_return_value() {
    ctx returns $return_value
}

test_crash_abort_after_return() {
    ctx returns $return_value
    ctx aborts 'should not raise an exception'
}

test_run_script_abort() {
    ctx aborts $error_msg
}

test_crash_return_after_abort() {
    ctx aborts $error_msg
    ctx returns 'should_not_return_this'
}

test_abort_returns_nonzero_exit_code() {
    set -e
    ctx aborts $error_msg 2> $output_file
    echo "this line shouldn't execute" > $output_file
}

test_abort_and_script_exits_elsewhere_with_nonzero_exit_code() {
    ctx aborts $error_msg
    exit 1
}

test_run_script_inputs_as_env_variables() {
    ctx returns "$custom_env_var"
}

test_run_script_inputs_as_env_variables_process_env_override() {
    ctx returns "$custom_env_var"
}

test_run_script_ctx_server_port() {
    ctx returns $CTX_SOCKET_URL
}

test_run_script_download_resource() {
    ctx returns $(cat $(ctx download-resource test_resource))
}

test_run_script_download_resource_and_render() {
    ctx returns $(cat $(ctx download-resource-and-render test_resource_render))
}

test_run_script_download_resource_explicit_target_path() {
    ctx download-resource test_resource /tmp/hello
    ctx returns $(cat /tmp/hello)
}

# Injected by test
${test_operation} $@
