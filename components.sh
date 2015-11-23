### Variables

##### Local
readonly COMPONENTS_VERSION=0.1.1
readonly COMPONENTS_TEMP_PATH=/tmp/components
readonly SCRIPT_NAME=$0

##### Global
readonly export COMPONENTS_BUILD_CACHE_PATH=$HOME/Library/Caches/Components
readonly export COMPONENTS_PATH=$PWD/Components
readonly export COMPONENTS_MAKE_PATH=$PWD/Components.make

### Messages

function argument_error() {
  message=""
  if [[ -z $1  ]]
  then
    message="command is missing"
  else
    message="invalid command: '$1'"
  fi
  echo "$message"
  echo "run '$SCRIPT_NAME' to see help"
}

function usage() {
cat << EOL
$SCRIPT_NAME version $COMPONENTS_VERSION

Usage:
  $SCRIPT_NAME [explain] command [components]

  command:
    install   - downloads, builds (if needed) and installs component 
                into a vendor directory (COMPONENTS_PATH)
    uninstall - removes component from a vendor directory (COMPONENTS_PATH)
    clean     - removes downloaded files and built artefacts from 
                cache dir (COMPONENTS_BUILD_CACHE_PATH)
    purge     - cleans and uninstalls component
    update    - uninstalls current and installs new version of a component

  explain:
    print the commands that would be executed, but do not execute them

  components:
    one or more component name, enumerates all components in the components 
    directory (COMPONENTS_MAKE_PATH) if the parameter is omitted

Directories:
  COMPONENTS_MAKE_PATH          - directory contains all components used in the current project
                                $COMPONENTS_MAKE_PATH
  COMPONENTS_PATH               - directory contains all installed components for the current project
                                $COMPONENTS_PATH
  COMPONENTS_BUILD_CACHE_PATH   - stores zip/tarballs, built artefacts, or source code of used components
                                $COMPONENTS_BUILD_CACHE_PATH

Examples:
  $SCRIPT_NAME install                # installs every component in the components directory (COMPONENTS_MAKE_PATH)
  $SCRIPT_NAME purge Cedar            # cleans and uninstalls Cedar library
  $SCRIPT_NAME update BloodMagic      # uninstalls current and installs new version of BloodMagic library
  $SCRIPT_NAME clean BloodMagic Cedar # cleans up Cedar' and BloodMagic' artefacts
  $SCRIPT_NAME explain install        # prints commands that would be executed to install each component
EOL
}

### Terminating

function show_argument_error_and_die() {
  argument_error $1 && exit 1
}

function show_usage_and_die() {
  usage && exit 1
}

### FS related stuff

function prepare_directories() {
  mkdir -p $COMPONENTS_BUILD_CACHE_PATH
  mkdir -p $COMPONENTS_PATH
  mkdir -p $COMPONENTS_TEMP_PATH
  mkdir -p $COMPONENTS_MAKE_PATH
}

### main

function main() {
  local explain=0
  local command=""
  local components=()
  
  if [[ $# -eq 0 ]]; then
    show_usage_and_die
  fi

  if [[ $1 == "explain" ]]; then
    explain=1
    shift
  fi

  case $1 in
    install|uninstall|clean|purge|update)
      command=$1
      shift
    ;;
    *)
      show_argument_error_and_die $1
    ;;
  esac

  components=$@

  if [[ -z $components ]]; then
    components=$(ls $COMPONENTS_MAKE_PATH | awk -F '.make' ' { print $1 } ')
  fi

  prepare_directories

  for component in $components; do
    logfile=$COMPONENTS_TEMP_PATH/$component.log
    make_flags="--warn-undefined-variables -r -d "
    executing_message="[$command] $component:"
    success_message=" done.\n"
    failure_message=" failed. See $logfile for details.\n"

    if [[ $explain -eq 1 ]]; then
      logfile=/dev/stdout
      make_flags="-n "$make_flags
      executing_message="$executing_message\n"
      success_message=""
      failure_message=""
    fi
      logfile=/dev/stdout

    make_parameters="$command $make_flags -f $COMPONENTS_MAKE_PATH/$component.make"
    
    printf "$executing_message"
    make $make_parameters > $logfile 2>&1 && printf "$success_message" || printf "$failure_message"
  done
}

main $@
