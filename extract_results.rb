#!/usr/bin/env ruby
out_dir = ARGV.first
results_1b = {}
results_50m = {}

def sort_results(results)
  keys = results.keys
  keys.sort_by do |key|
    row = results[key]
    (row && row[0]) || "99:99:99"
  end
end

Dir.glob(File.join(out_dir, "*.txt")).each do |filename|
  time = nil
  cpu = nil
  mem = nil
  exit_status = nil

  File.read(filename).each_line do |line|
    case line
    when /\A\s+Elapsed \(wall clock\) time \(h:mm:ss or m:ss\):\s+(.+)\n/
      time = $1.rjust(8, '0')

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

  case File.basename(filename).split(".")
  in [contrib, "1B", "txt"]
    results_1b[contrib] = [time, cpu, mem, exit_status]

  in [contrib, "50M", "txt"]
    results_50m[contrib] = [time, cpu, mem, exit_status]
  end
end

keys = results_50m.keys

###
# First let's print the 50M results
###

rows = [
  "| Contributor | Time (50M) | CPU% (50M) | Mem kb (50M) | Comments |",
  "| ----------- | ---------- | ---------- | ------------ | -------- |",
]

template = "| %40s | %10s | %10s | %12s | %9s |"

# Sort keys based on the Time (50M) in ascending order
sorted_keys = sort_results(results_50m)

sorted_keys.each do |key|
  time50M, cpu50M, mem50M, exitStatus50M = *results_50m[key]

  comment = if exitStatus50M == 0 then "" else "Exit status: #{exitStatus50M}" end

  rows.push(template % [key, time50M, cpu50M, mem50M, comment])
end
puts "Here are the 50M Results:"
puts rows

puts ""
puts ""
puts ""

###
# Now let's print the 1B results
###
keys = results_1b.keys

rows = [
  "| Contributor | Time (1B)  | CPU% (1B)  | Mem kb (1B)  | Comments |",
  "| ----------- | ---------- | ---------- | ------------ | -------- |",
]

template = "| %40s | %10s | %10s | %12s | %9s |"

# Sort keys based on the Time (1B) in ascending order
sorted_keys = sort_results(results_1b)

sorted_keys.each do |key|
  time1B, cpu1B, mem1B, exitStatus1B = *results_1b[key]

  comment = if exitStatus1B == 0 then "" else "Exit status: #{exitStatus1B}" end

  rows.push(template % [key, time1B, cpu1B, mem1B, comment])
end
puts "Here are the 1B Results:"
puts rows
