
require 'yaml'
require_relative 'toy_robot'

module Board

  class Play

    include ToyRobot

    def initialize
      @place_position = Place.new().get_values
    end

    def move
      if validate_movement? @place_position
        common_message("Robbot is trying to move out from board, placing original position 0,0 facing North !")
        record_movement({:x => 0, :y => 0, :f => "North"}, 0)
      else
        face = @place_position.values_at(:f)[0]
        if %w(East West).include?(face)
          latest_position = @place_position.each {|k, v| @place_position[k] = v.to_i+1 if k==:x}
        elsif %w(North South).include?(face)
          latest_position = @place_position.each {|k, v| @place_position[k] = v.to_i+1 if k==:y}
        end  
        record_movement latest_position # Record position in YML file
        print_position latest_position
      end
    end

    def left
      rotate_90 @place_position, "left"
    end

    def right
      rotate_90 @place_position, "right"
    end

    def rotate_90 options, movement
      f = options.values_at(:f)[0]
      if movement == "right"
        case f
         when "West"
          latest_position = @place_position.each {|k, v| @place_position[k] = "North" if k==:f}
         when "East"
          latest_position = @place_position.each {|k, v| @place_position[k] = "South" if k==:f}
         when "North" 
          latest_position = @place_position.each {|k, v| @place_position[k] = "East" if k==:f}
         when "South"
          latest_position = @place_position.each {|k, v| @place_position[k] = "West" if k==:f}
         end
      else
        case f
         when "West"
          latest_position = @place_position.each {|k, v| @place_position[k] = "South" if k==:f}
         when "East"
          latest_position = @place_position.each {|k, v| @place_position[k] = "North" if k==:f}
         when "North" 
          latest_position = @place_position.each {|k, v| @place_position[k] = "West" if k==:f}
         when "South"
          latest_position = @place_position.each {|k, v| @place_position[k] = "East" if k==:f}
         end
      end
       record_movement latest_position  
       print_position latest_position
    end

    def validate_movement? options
      x = options.values_at(:x)[0]
      y = options.values_at(:y)[0]
      f = options.values_at(:f)[0]

      total = x + y

      p print_position @place_position

      if total > 8
        common_message("Can't place robot out of Board !")
        return true
      else
        case f
         when "West"
          p "Robot facing west"
          (0..4).to_a.include?(x) && (0..4).to_a.include?(total)
         when "North" 
          p "Robot facing north"
          (4..8).to_a.include?(y) && (4..8).to_a.include?(total)
         when "East"
          p "Robot facing east"
          (4..8).to_a.include?(x) && (4..8).to_a.include?(total)
         when "South"
          p "Robot facing south"
          (0..4).to_a.include?(y) && (0..4).to_a.include?(total)
        end
      end
    end

    def common_message(message = nil)
      p message
    end

    def print_position values
      @place_position.to_a.each_with_index do |p|
        p "#{p[0]} => #{p[1]}"
      end
    end

    def record_movement(latest_postion, track = nil)

      x = latest_postion.values_at(:x)[0]
      y = latest_postion.values_at(:y)[0]
      f = latest_postion.values_at(:f)[0]

      lrp = YAML::load_file('record.yml') #Load
      track_r = track ? track : lrp['position']['track'].to_i + 1
      lrp['position']['x'] = x #Modify X position
      lrp['position']['y'] = y #Modify Y position
      lrp['position']['f'] = f #Modify face direction
      lrp['position']['track'] = track_r #Modify track record
      File.open('record.yml', 'w') {|f| f.write lrp.to_yaml } #Save Updated position
    end

  end
end


read_instructions = YAML::load_file('instruction.yml')

p read_instructions