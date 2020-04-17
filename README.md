# shuz

Shell scripting utilz for aficionados of aesthetic scripts.

This is a collection of simple shell scripting utilities that I cultivated over
the years of writing uncountable amount of scripts in Linux/MacOS environments.
They are definitely opinionated, are in no way intended to address all the
possible scripting problems or give a complete solution to anything. But they
are battle proven and do their simple job very well.


## Quick start

1. Clone the repository or just download `shuz.sh`.
2. Make sure `shuz.sh` location is in `PATH`.
3. Add `source shuz.sh` to the beginning of your shell script.

This library uses a number of [bashisms](https://en.wiktionary.org/wiki/bashism)
as a compromise between usability, simplicity and portability. To mitigate most 
portability issues, always start your scripts with this shebang:

```shell script
#!/usr/bin/env bash
```


## Overview

Run `example.sh` for a demonstration of the library features.

### Terminal output functions

- `ec` - More consistent echo.
- `ecn` - More consistent echo; without the new line.
- `br` - Outputs new line.
- `success` - Informs that everything goes as planned.
- `warn` - Outputs a menasing message.
- `error` - Outputs a scary message.
- `fail` - Outputs a message and kills the script.

### Terminal colors

shuz defines a set of variables containing ANSI escape codes controlling output
color. The most common are: `bold`, `black`, `red`, `green`, `yellow`, `blue`, 
`magenta`, `cyan` and `white`. Use `noc` (no color) to reset the styling.
For example:

```shell script
ec "The last word will be printed in ${blue}blue${noc}"
```

### Other functions

- `multiline` - Reads multiline text from stdin into a variable.
- `indent` - Reads multiline text from stdin and outputs it indented.
- `are_you_sure` - Ask user a yes/no question.
