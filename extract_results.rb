#!/usr/bin/env ruby

def parse_results(out_dir)
  results = {}
  Dir.glob(File.join(out_dir, "*.txt")).each do |filename|
    time = nil
    cpu = nil
    mem = nil
    exit_status = nil

    File.read(filename).each_line do |line|
      case line
      when /\A\s+Elapsed \(wall clock\) time \(h:mm:ss or m:ss\):\s+(.+)\n/
        time = $1

      when /\A\s+Percent of CPU this job got:\s+(.+)\n/
        cpu = $1

      when /\A\s+Maximum resident set size \(kbytes\):\s+(.+)\n/
        mem = $1
      when /\A\s+Exit status:\s+(\d+)\n/
        exit_status = ($1).to_i

      else
        p line
      end
    end

    contrib, bench =
    case File.basename(filename).split(".")
    in [contrib, "1B", "txt"]
      [contrib, "1B"]
    in [contrib, "50M", "txt"]
      [contrib, "50M"]
    end

    result = {contrib: contrib, time: time, cpu: cpu, mem: mem, exit_status: exit_status}

    results[bench] ||= []
    results[bench] << result
  end
  results
end

def print_results(results, variant)
  colwidth = [40, 13, 10, 12, 11]
  template = "| " + colwidth.map{|c| "%#{c}s"}.join(" | ") + " |"

  puts "Here are the #{variant} Results:"

  puts(template % ["Contributor", "Time (#{variant})", "CPU% (#{variant})", "Mem kb (#{variant})", "Comments"])
  puts(template % colwidth.map{|c| "-" * c})

  results.sort_by {|r| r[:time]}.each do |r|
    failed = r[:exit_status] != 0
    comment = if failed then "Exit: #{r[:exit_status]}" else "" end

    values = [r[:contrib], r[:time], r[:cpu], r[:mem], comment]

    # Strike-trough failed results
    values = values.map {|v| "~~#{v}~~"}.to_a if failed

    puts(template % values)
  end

  puts ""
  puts ""
  puts ""
end

if __FILE__ == $0
  out_dir = ARGV.first
  results = parse_results(out_dir)
  print_results(results["50M"] || [], "50M")
  print_results(results["1B"] || [], "1B")
end
