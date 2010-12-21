class GodMonitoring < Scout::Plugin
  def build_report
    god_command = option(:god_command_name) || "/usr/bin/god"
    pgrep_output = `pgrep -f #{god_command}`

    god_processes = pgrep_output.split(/\n/)
    report :god_processes => god_processes.size
    if god_processes.size == 0
      alert "No god processes found, expected exactly 1"
    elsif god_processes.size > 1
      alert "Multiple god processes found, expected exactly 1", pgrep_output
    end

    god_status_command = option(:god_status_command) || "sudo god status"
    god_status_output = `#{god_status_command}`
    unless $?.success?
      alert "'#{god_status_command}' not returning sane results", god_status_output
    end
  end
end
