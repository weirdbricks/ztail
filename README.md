# ztail

Like the linux `tail` command but for gzip compressed files

# Usage

## Tail a file

By default the functionality of `-f` is emulated

```
./ztail ~/test.log.gz
```

## Stop following a file:

`Ctrl+C`

# Build

* Install Crystal 0.27
* Checkout this repo
* Build with: `crystal build --static --release ztail.cr`

# Known issues

* High CPU usage as it needs to re-read the gzip file in every iteration
