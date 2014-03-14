require 'yaml'

module ToyRobot
 class Place

  def initialize(options = {})
    @options = options.empty? ? self.class.default_options : options
  end

  def self.default_options
    lrt = YAML::load_file('record.yml')
    track = lrt['position']['track']
    if track == 0
      {:x => 0, :y => 0, :f => "North"}
    else
      {:x => lrt['position']['x'], :y => lrt['position']['y'], :f => lrt['position']['f']}
    end
  end

  def get_values
    @options
  end

 end
end