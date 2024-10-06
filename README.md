# shuz

Shell utilz for ergonomic shell scripting.

This is a collection of simple shell scripting utilities that I cultivated over
the years of writing uncountable amount of scripts in Linux/MacOS environments.
They are definitely opinionated, are in no way intended to address all the
possible scripting problems or give a complete solution to anything. But they
are battle proven and do their simple job very well.

Supports Bash and Zsh.

## Quick start

1. Clone the repository or just download `shuz.sh`.
2. Make sure `shuz.sh` location is in `PATH`.
3. Add `source shuz.sh` to the beginning of your shell script.

## Overview

Run `test-zsh.sh` or `test-bash.sh` for a demonstration of the library features.

### Terminal output functions

- `shuz::ec` - More consistent echo.
- `shuz::ecn` - More consistent echo; without the new line.
- `shuz::br` - Outputs new line.
- `shuz::success` - Informs that everything goes as planned.
- `shuz::warn` - Outputs a menasing message.
- `shuz::error` - Outputs a scary message.
- `shuz::fail` - Outputs a message and kills the script.

### Assertions and expectations

- `shuz::assert_success` - Outputs a message and kills the script if the
   previous command failed.
- `shuz::expect_command`- Succeeds if the command in the argument can be found.
- `shuz::assert_command`- Outputs a message and kills the script if the
   command in the argument cannot be found.

### Terminal colors

shuz defines a set of variables containing ANSI escape codes controlling output
color. The most common are: `bold`, `black`, `red`, `green`, `yellow`, `blue`, 
`magenta`, `cyan` and `white`. Use `noc` (no color) to reset the styling.
For example:

```shell script
ec "The last word will be printed in ${blue}blue${noc}"
```

### Other functions

- `shuz::multiline` - Reads multiline text from stdin into a variable.
- `shuz::indent` - Reads multiline text from stdin and outputs it indented.
- `shuz::are_you_sure` - Ask user a yes/no question.
