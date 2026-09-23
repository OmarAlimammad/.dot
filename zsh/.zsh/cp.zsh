# Read stdin into the file `run -` uses.
in() {
  cat > "input"
}

# Clear a log file and follow it.
watch() {
  local f=${1:-output}

  # This truncates its argument, so a slip like `watch a.cpp` would destroy a
  # solution. Nothing here should ever be pointed at source.
  case ${f:e} in
    (cpp|cc|cxx|c|h|hh|hpp|py|rs|java|go|zsh|sh)
      print -u2 "watch: refusing to truncate a source file: $f"
      return 2 ;;
  esac

  # Truncate rather than rm+touch: the inode survives, so a program already
  # writing to the file keeps working and tail does not lose its handle.
  : > "$f" || return
  clear
  tail -n +1 -f "$f"
}

# Binary for a source file: $1 = mode (opt|dbg), $2 = first source.
_cp_binpath() {
  local b=".cache/${2:t:r}"
  [[ $1 == dbg ]] && b="${b}.dbg"
  print -r -- "$b"
}

# build [-d] <source...>
#
# One cached binary per source. Everything used to compile to a single ./bin,
# so a timestamp check could not tell the binary came from a *different*
# source: after building a.cpp, an older b.cpp still looked up to date and
# `run b.cpp` silently ran A's program. Keying on the source name fixes that,
# and switching between problems no longer recompiles.
build() {
  local mode="opt"
  if [[ $1 == "-d" || $1 == "--debug" ]]; then
    mode="dbg"; shift
  fi
  (( $# )) || { print -u2 "build: usage: build [-d] <source...>"; return 2 }

  local flags=""
  [[ $mode == dbg ]] && flags="-g -fsanitize=address,undefined"

  local bin stamp key
  bin="$(_cp_binpath $mode "$1")"
  stamp="${bin}.flags"
  key="clang++ ${flags} -- $*"

  mkdir -p "${bin:h}" || return

  local rebuild=0 src
  [[ -f $bin ]] || rebuild=1
  [[ -f $stamp && "$(<$stamp)" == "$key" ]] || rebuild=1   # flags changed
  for src in "$@"; do
    [[ $src -nt $bin ]] && { rebuild=1; break }
  done
  (( rebuild )) || return 0

  # Drop the stamp first so a failed compile can never leave a binary that
  # claims to be current.
  rm -f "$stamp"
  clang++ ${=flags} -o "$bin" "$@" || return
  print -r -- "$key" > "$stamp"
}

# run [-] [-d] <source...>
#   -    read stdin from ./input instead of the terminal
#   -d   build with sanitizers
run() {
  local mode="opt" infile="/dev/stdin"

  while (( $# )); do
    case $1 in
      (-)          infile="input"; shift ;;
      (-d|--debug) mode="dbg";     shift ;;
      (--)         shift; break ;;
      (-*)         print -u2 "run: unknown option: $1"; return 2 ;;
      (*)          break ;;
    esac
  done
  (( $# )) || { print -u2 "run: usage: run [-] [-d] <source...>"; return 2 }

  if [[ $mode == dbg ]]; then
    build -d "$@" || return
  else
    build "$@" || return
  fi

  [[ $infile == /dev/stdin || -r $infile ]] || {
    print -u2 "run: no such input file: $infile"; return 2
  }

  "$(_cp_binpath $mode "$1")" < "$infile"
}
