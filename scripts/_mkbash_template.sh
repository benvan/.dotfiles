#!/usr/bin/env bash
source $(which bash_to_basics)

# Default variable values
output_file=false
verbose_mode=false

# Function to handle options and arguments
handle_options() {
  while [ $# -gt 0 ]; do
    arg=$1
    case $1 in
      -v | --verbose) # Verbose mode
        verbose_mode=true
				shift
        ;;
      -f | --file*) # Specify an output file
				output_file=$(extract_required_argument file $@)
				shift; shift;
        ;;
    esac
		handle_fallthrough $arg ${1:-}
  done
}

# Main script execution
handle_options "$@"
# Uncomment to require options are provided
require_options "$@"

# YOUR SCRIPT GOES HERE!
if [ "$verbose_mode" = true ]; then
 echo "Verbose mode enabled."
fi

if [ -n "$output_file" ]; then
 echo "Output file specified: $output_file"
fi



