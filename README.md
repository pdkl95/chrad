# ChRad

Change Radix. A command line utility to convert integer bases.

Arbitrarily large numbers are supported thanks to ruby's built-in
support for bignums. Conversion to or from any positive integer fixed
base system is supported.

Mixed-radix systems are not supported. For converting numbers in the factoradic
(factorial base) system, use my [factoradic gem][fact_gem] or [faster c utility][c_util].

[fact_gem]: https://github.com/pdkl95/factoradic

[c_util]: https://github.com/pdkl95/factoradic_c_utils


## Installation

Run:

    gem install chrad


## Usage

### The command line utility

#### Options

```
Usage: chrad [options] -i <input_base> -o <output_base> <number> [...]

REQUIRED OPTIONS

  -i, --input=BASE         Interpret input strings integers in base <BASE>
  -o, --output=BASE        Print converted numbers as integers in base <BASE>

INPUT/OUTPUT FORMAT

      --input-list         Input values as delimiter separated lists
      --output-list        Output values as delimiter separated lists
  -l, --list               Both input and output values as delimiter separated lists
                           (Shorthand for using both --input-list and --output-list)
      --input-sep=CHAR     Use <CHAR> as the delimiter between places
                           in input vales when using --input-list mode
      --output-sep=CHAR    Use <CHAR> as the delimiter between places
                           in output vales when using --output-list mode
  -s, --separator=CHAR     Use <CHAR> as the delimiter between places in both
                           input and output list modes. (shorthand for using
                           both --input-separator=CHAR and --output-separator=CHAR)

DIGIT ALPHABET

      --input-digits=STR   Use the given <STR> as the set of chars to use
                           when interpreting input integers.
                           (Ignored when using--input-list mode.)
      --output-digits=STR  Use the given <STR> as the set of chars to use
                           when printing number in the output base.
                           (Ignored when using--input-list mode.)
  -d, --digits=STR         Use the given <STR> as the set of chars to use
                           for both input and output. (shorthand for using
                           both --input-digits=STR and --output-digits=STR)

      --list-named-digits  List the built-in named digit sets. These names
                           can be passed to any of --digits, --input-digits,
                           or --output-digits using the \"name:\" prefix.
                           (example: \"--digits=base64\")
  -h, --help               Show this help message
      --version            Show version
```


#### Examples

```
$ chrad -i 10 -o 16 255
ff

$ chrad -i 16 -o 2 c9
11001001

$ chrad -i 10 -o 64 --output-digits=name:base64 129633344153503
deadbeef

$ chrad -i 10 -o 64 --output-list 129633344153503
29,30,26,29,27,30,30,31

$ chrad -i 64 -o 64 --input-list --output-digits=name:base64 29,30,26,29,27,30,30,31
deadbeef

$ chrad -i 10 -o 4 --output-digits='♠♡♢♣' 4321
♡♠♠♣♢♠♡

$ print3nums() { echo 255 ; echo 65535 ; echo 16777215 ; }
$ print3nums | chrad -i 10 -o 16 --stdin
ff
ffff
ffffff
```


### Input/Output

To represent a number in a given base, a set of digits must be available
that is at least as large as that base. To support this, chrad allows
you to provide a string of characters to use for input, output, or
both (with `--input-digits`, `--output-digits`, and `--digits`
respectively).

```
$ chrad -i 16 -o 3 --output-digits .-/ 5717063
/.-../---/...-/./
```


#### Built-in Digit Sets

Several commonly used sets of digits are built-in. To use a built-in
set, use the name of the wet with the `--digits` options and a `name:`
prefix.

```
$ chrad -i 16 -o 64 --output-digits=name:base64 dea
```

The built-in digit sets are:
```
$ chrad --list-named-digits
name:base62     ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
name:base64     ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/
name:base64url  ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_
name:base32rfc  ABCDEFGHIJKLMNOPQRSTUVWXYZ234567
name:base32     0123456789abcdefghijklmnopqrstuv
name:base16     0123456789abcdef
```

The sets `base16` and `base32` are the common hexadecimal-style
extension of the base 10 digits. The sets `base64`, `base64url`, and
`base32rfc` are from [RFC 3548][rfc3548].

[rfc3548]: https://datatracker.ietf.org/doc/html/rfc3548


#### List Mode

When converting numbers in very large bases, finding appropriate
characters to use becomes difficult. To avoid this problem, use list
mode. List mode can also make integration easier because it is a
base-independent representation.

List mode can be enabled for input, output, or both with
`--input-list`, `--output-list`, and `-l/--list` respectively. When
list mode is enabled, numbers are represented as a comma (`","`)
separated list of base 10 integers.

```
$ chrad -i 10 -o 64 --output-list  16772988
63,62,61,60

$ chrad -i 64 -o 16 --input-list 3,30,43,27,59,47
deadbeef

$ chrad -i 8 -o 16 --list 5,4,3,2,1
5,8,13,1
```

The comma separator can be changed to any character with the
`--input-sep`, `--output-sep`, and `-s/--separator` options.

```
$ chrad -i 10 -o 64 --output-list --output-sep=: 16772988
63:62:61:60
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pdkl95/chrad.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
