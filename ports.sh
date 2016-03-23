### Variables

##### Local
PORTS_VERSION=0.1.0
PORTS_EXEC=$0
PORTS_TEMP_DIR=/tmp/ports

##### Global
export PORTS_VENDOR_DIR=$PWD/Vendor
export PORTS_CACHE_DIR=$HOME/Library/Caches/Ports
export PORTS_DIR=$PWD/ports

### Input Validation

function is_command_valid() {
  cmd=$1
  commands=("install" "uninstall" "clean" "purge" "update")
  for c in $commands; do [[ $c == $cmd ]] && return 0; done
  return 1
}

function is_input_valid() {
  return $([ $# -ne 0 ])
}

### Command status reports

function show_command_executing() {
  command=$1
  port=$2
  printf "[$command] $port: "
}

function show_command_error() {
  logfile=$1
  printf "failed. See $logfile for details.\n"
}

function show_command_success() {
  printf "done.\n"
}

### Messages

function argument_error() {
cat << EOL
invalid command: $cmd
run '$PORTS_EXEC' to see help
EOL
}

function usage() {
cat << EOL
$PORTS_EXEC version $PORTS_VERSION

Usage:
  $PORTS_EXEC command [ports]

  command:
    install   - downloads, builds (if needed) and installs port 
                into a vendor directory (PORTS_VENDOR_DIR)
    uninstall - removes port from a vendor directory (PORTS_VENDOR_DIR)
    clean     - removes downloaded files and built artefacts from 
                cache dir (PORTS_CACHE_DIR)
    purge     - cleans and uninstalls port
    update    - uninstalls current and installs new version of a port

  ports:
    one or more port name, enumerates all ports in the ports 
    directory (PORTS_DIR) if the parameter is omitted

Directories:
  PORTS_DIR         - directory contains all ports used in the current project
                      $PORTS_DIR
  PORTS_CACHE_DIR   - stores zip/tarballs, built artefacts, or source code of used ports
                      $PORTS_CACHE_DIR
  PORTS_VENDOR_DIR  - directory contains all installed ports for the current project
                      $PORTS_VENDOR_DIR

Examples:
  $PORTS_EXEC install                # installs every port in the ports directory (PORTS_DIR)
  $PORTS_EXEC purge Cedar            # cleans and uninstalls Cedar library
  $PORTS_EXEC update BloodMagic      # uninstalls current and installs new version of BloodMagic library
  $PORTS_EXEC clean BloodMagic Cedar # cleans up Cedar' and BloodMagic' artefacts
EOL
}

### Terminating

function show_argument_error_and_die() {
  argument_error && exit 1
}

function show_usage_and_die() {
  usage && exit 1
}

### FS related stuff

function logfile_for_port() {
  port=$1
  echo "$PORTS_TEMP_DIR/$port.log"
}

function prepare_directories() {
  mkdir -p $PORTS_CACHE_DIR
  mkdir -p $PORTS_VENDOR_DIR
  mkdir -p $PORTS_TEMP_DIR
}

### main

function ports() {
  # proceed with all ports in 'ports' directory if there is one argument
  # otherwise proceeed with ports passed to the script
  #
  # "shift 1 && echo $@" 'removes' first object from array '$@'
  echo $([ $# -eq 1 ] && ls $PORTS_DIR || (shift 1 && echo $@))
}

function run() {
  command=$1
  if is_command_valid $command
  then
    for port in $(ports $@); do
      execute_command_with_port $command $port
    done
  else
    show_argument_error_and_die $@
  fi
}

function execute_command_with_port() {
  command=$1
  port=$2
  logfile=$(logfile_for_port $port)
  makefile="$PORTS_DIR/$port/Makefile"

  show_command_executing $command $port
  make $command -f $makefile &>$logfile && show_command_success || show_command_error $logfile
}

function main() {
  prepare_directories
  is_input_valid $@ && run $@ || show_usage_and_die
}

main $@

