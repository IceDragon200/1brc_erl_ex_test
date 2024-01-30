#!/usr/bin/env ruby
out_dir = ARGV.first
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

def print_results(results, variant)
  template = "| %40s | %10s | %10s | %12s | %9s |"

  puts "Here are the #{variant} Results:"
  puts "| Contributor | Time (#{variant}) | CPU% (#{variant}) | Mem kb (#{variant}) | Comments |"
  puts "| ----------- | ---------- | ---------- | ------------ | -------- |",

  results.sort_by {|r| r[:time]}.each do |r|
    failed = r[:exit_status] != 0
    comment = if failed then "Failed with: #{r[:exit_status]}" else "" end

    values = [r[:contrib], r[:time], r[:cpu], r[:mem], comment]

    # Strike-trough failed results
    if failed
      values = values.map {|v| "~~#{v}~~"}
    end

    puts(template % values)
  end

  puts ""
  puts ""
  puts ""
end

print_results(results["50M"], "50M")
print_results(results["1B"], "1B")


