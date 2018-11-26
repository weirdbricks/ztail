# ztail
like the linux `tail` command but for gzip compressed files

# Usage

## Tail a file

```
./ztail ~/test.log.gz
```

# Build

* Install Crystal 0.27
* Checkout this repo
* Build with: `crystal build --static --release ztail.cr`
