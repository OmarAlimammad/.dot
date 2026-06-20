in() {
  cat > "input"
}

watch() {
  rm "$1"
  touch "$1"
  clear
  tail -n +1 -f "$1"
}

build() {
  local bin="bin"
  local rebuild=0

  [[ ! -f $bin ]] && rebuild=1

  for src in "$@"; do
    [[ $src -nt $bin ]] && { rebuild=1; break; }
  done

  if (( rebuild )); then
    clang++ -o "$bin" "$@"
  fi
}

run() {
  local bin="bin"
  local infile="/dev/stdin"

  if [[ $1 == "-" ]]; then
    infile="input"
    shift
  fi

  build "$@"
  ./"$bin" < "$infile"
}
