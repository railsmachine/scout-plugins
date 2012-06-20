class PostfixQeueue < Scout::Plugin
 def build_report
    queue_status = `/usr/sbin/postqueue -p`
    lines=queue_status.split("\n")
    
    reasons=Hash.new(0)
    lines.each do |line|
      if line =~ /\s(.*)/
        if line.match(/:25: (.*)\)/)
          reason=$1.downcase.gsub(" ","_")
          reasons[reason]+=1
        end
      end
    end
 
    summary=lines.last   
    if queue_status =~ /queue is empty/  
      outgoing = 0
    else
      outgoing = summary.match(/in (\d*) request[s]?/i)[1].to_i
    end
    hash={:queued_total => outgoing}
    hash.merge!(reasons)
    report(hash)
  end
end
