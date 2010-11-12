require File.dirname(__FILE__)+"/../test_helper"
require File.dirname(__FILE__)+"/mod_pagespeed"
require 'mocha'

class ModPagespeedTest < Test::Unit::TestCase
  def test_parsing
    plugin = ModPagespeedPlugin.new(nil, {}, :url => fixture_path)
    res = plugin.run
    report = Hash[res[:reports].first]
    # just check a few
    assert_equal 20, report['resource_url_domain_rejections']
    assert_equal 432167, report['serf_fetch_time_duration_ms']
  end

  def fixture_path
   File.dirname(__FILE__)+'/fixtures/mod_pagespeed_statistics' 
  end
end

