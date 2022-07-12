# ChRad

Change Radix. A command line utility to convert integer bases.

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
                           input and output list modes. (shothand for using
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
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pdkl95/chrad.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
