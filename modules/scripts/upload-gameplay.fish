if test (count $argv) -eq 0
    echo "Usage: upload-gameplay <file>..." >&2
    exit 1
end

set urls
set failures
for file in $argv
    if rc cp $file captures/kwarf-replays/
        set -a urls https://s3.eu-central-1.wasabisys.com/kwarf-replays/(path basename $file | string escape --style=url)
    else
        set -a failures $file
    end
end

if set -q urls[1]
    printf '%s\n' $urls
    printf '%s\n' $urls | wl-copy
    echo "URLs have been copied to clipboard"
end

if set -q failures[1]
    echo "Upload failed for:" >&2
    printf '%s\n' $failures >&2
    exit 1
end
