require 'change_base'
require 'optparse'

module ChangeBase
  class CLI
    attr_reader :argv

    def initialize(argv = ARGV)
      @argv = argv.map do |x|
        x.to_s
      end
    end

    def input
      @input ||= ChangeBase::InputManager.new
    end

    def output
      @output ||= ChangeBase::OutputManager.new
    end

    def optparse
      @optparse ||= OptionParser.new do |opts|
        opts.banner = "Converts integers into a different base (radix)."
        opts.define_head "Usage: #{$0} [options] -i <input_base> -o <output_base> <number> [...]"
        opts.summary_width = 24
        opts.summary_indent = '  '

        opts.separator ''
        opts.separator 'REQUIRED OPTIONS'
        opts.separator ''

        opts.on('-iBASE', '--input=BASE',
                'Interpret input strings integers in base <BASE>'
               ) do |base|
          input.base = base
        end

        opts.on('-oBASE', '--output=BASE',
                'Print converted numbers as integers in base <BASE>'
               ) do |base|
          output.base = base
        end


        opts.separator ''
        opts.separator 'INPUT/OUTPUT FORMAT'
        opts.separator ''

        opts.on('--input-list',
                'Input values as delimiter separated lists'
               ) do
          input.mode = :list
        end

        opts.on('--output-list',
                'Output values as delimiter separated lists'
               ) do
          output.mode = :list
        end

        opts.on('-l', '--list',
                'Both input and output values as delimiter separated lists',
                '(Shorthand for using both --input-list and --output-list)'
               ) do
          input.mode = :list
          output.mode = :list
        end

        opts.on('--input-sep=CHAR',
                'Use <CHAR> as the delimiter between places',
                'in input vales when using --input-list mode'
               ) do |sep|
          input.separator = sep
        end

        opts.on('--output-sep=CHAR',
                'Use <CHAR> as the delimiter between places',
                'in output vales when using --output-list mode'
               ) do |sep|
          output.separator = sep
        end

        opts.on('-s', '--separator=CHAR',
                'Use <CHAR> as the delimiter between places in both',
                'input and output list modes. (shothand for using',
                'both --input-separator=CHAR and --output-separator=CHAR)'
               ) do |sep|
          input.separator = sep
          output.separator = sep
        end

        opts.separator ''
        opts.separator 'DIGIT ALPHABET'
        opts.separator ''

        opts.on('--input-digits=STR',
                'Use the given <STR> as the set of chars to use',
                'when interpreting input integers.',
                '(Ignored when using--input-list mode.)'
               ) do |str|
          input.alphabet = str
        end

        opts.on('--output-digits=STR',
                'Use the given <STR> as the set of chars to use',
                'when printing number in the output base.',
                '(Ignored when using--input-list mode.)'
               ) do |str|
          output.alphabet = str
        end

        opts.on('-d', '--digits=STR',
                'Use the given <STR> as the set of chars to use',
                'for both input and output. (shorthand for using',
                'both --input-digits=STR and --output-digits=STR)'
               ) do |str|
          input.alphabet = str
          output.alphabet = str
        end


        opts.separator ''

        opts.on('-h', '--help', 'Show this help message') do
          puts opts
          exit
        end

        opts.on('--version', 'Show version') do
          puts ChangeBase::VERSION
          exit
        end
      end
    end

    def run!
      optparse.parse!(argv)

      if argv.length > 0
        unless argv.first == '-'
          input.stream = argv
        end
      else
        puts optparse
        exit 1
      end

      input.setup_base_digits!
      output.setup_base_digits!

      input.stream.each do |arg|
        number = input.parse(arg)
        output.stream_puts(number)
      end
    end
  end
end
