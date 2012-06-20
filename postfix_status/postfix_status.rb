class PostfixStatus < Scout::Plugin
  def build_report
    postfix = `sudo /etc/init.d/postfix status`
    if postfix !~ /postfix is running/
      report(:status => 'ERR')
      alert('Postfix not running!')
    else
      report(:status => 'OK')
    end
  end
end
