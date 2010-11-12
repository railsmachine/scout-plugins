class ModPagespeedPlugin < Scout::Plugin
  needs 'open-uri'
  needs 'yaml'

  def build_report
    statistics = open(option(:url))

    report YAML.load(statistics)
  end
end
