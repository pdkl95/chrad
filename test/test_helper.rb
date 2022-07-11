# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "change_base"
require "change_base/cli"

require "minitest/autorun"


class ChangeBaseTest <  Minitest::Test
  make_my_diffs_pretty!

  def run_change_base(opts)
    out, err = capture_io do
      ChangeBase::CLI.new(opts).run!
    end
    assert_empty err, 'nothing shoule be written to STDOUT'
    out.chomp!
    out
  end

  def assert_changes_base(ibase, ivalue, obase, ovalue, *other)
    msg = nil
    opt = {}

    case other.length
    when 0
      # eo nothing
    when 1
      case other.first
      when String then msg = other.first
      when Hash   then opt = other.first
      end
    when 2
      opt, msg = other
    else
      raise Error, "Too many optional args: #{other.inspect}"
    end

    msg = message(msg) do
      "Converting #{mu_pp(ivalue)} from base #{mu_pp(ibase)} into base #{mu_pp(obase)} returned the wrong value"
    end

    args = [ '-i', ibase, '-o', obase, ivalue]

    args.concat(['-d', opt[:digits].to_s])            if opt.has_key?(:digits)
    args.concat(['-d', "name:#{opt[:dname]}"])        if opt.has_key?(:dname)
    args.concat(["--input-digits=#{opt[:idigits]}"])  if opt.has_key?(:idigits)
    args.concat(["--output-digits=#{opt[:odigits]}"]) if opt.has_key?(:odigits)
    args.concat(opt[:args])                           if opt.has_key?(:args)

    result = run_change_base(args)
    assert_equal ovalue, result, msg
  end

  def assert_all_base_changes(ibase, ivalue, obase, ovalue, *other)
    assert_changes_base ibase, ivalue, obase, ovalue, *other
    assert_changes_base obase, ovalue, ibase, ivalue, *other
  end
end
