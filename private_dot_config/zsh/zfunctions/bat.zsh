
if command -v "bat" &>/dev/null; then
    # NOTE: global `-h`/`--help` aliases were removed — they rewrote *every*
    # occurrence of those tokens on the command line (e.g. `grep -h pattern`
    # lost its "suppress filename headers" meaning).
    alias cat='bat --style=plain --paging=never --color always'
fi
