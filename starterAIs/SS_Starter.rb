STDOUT.sync = true # DO NOT REMOVE

# Define the data structures as structs
Vector = Struct.new(:x, :y)
FishDetail = Struct.new(:color, :type)
Fish = Struct.new(:fish_id, :pos, :speed, :detail)
Drone = Struct.new(:drone_id, :pos, :dead, :battery, :scans)
RadarBlip = Struct.new(:fish_id, :dir)

fish_details = {}

fish_count = gets.to_i
fish_count.times do
  fish_id, color, type = gets.split.map(&:to_i)
  fish_details[fish_id] = FishDetail.new(color, type)
end

# game loop
loop do
  my_scans = []
  foe_scans = []
  drone_by_id = {}
  my_drones = []
  foe_drones = []
  visible_fishes = []
  my_radar_blips = {}

  my_score = gets.to_i
  foe_score = gets.to_i

  my_scan_count = gets.to_i
  my_scan_count.times do
    fish_id = gets.to_i
    my_scans << fish_id
  end

  foe_scan_count = gets.to_i
  foe_scan_count.times do
    fish_id = gets.to_i
    foe_scans << fish_id
  end

  my_drone_count = gets.to_i
  my_drone_count.times do
    drone_id, drone_x, drone_y, dead, battery = gets.split.map(&:to_i)
    pos = Vector.new(drone_x, drone_y)
    drone = Drone.new(drone_id, pos, dead, battery, [])
    drone_by_id[drone_id] = drone
    my_drones << drone
    my_radar_blips[drone_id] ||= []
  end

  foe_drone_count = gets.to_i
  foe_drone_count.times do
    drone_id, drone_x, drone_y, dead, battery = gets.split.map(&:to_i)
    pos = Vector.new(drone_x, drone_y)
    drone = Drone.new(drone_id, pos, dead, battery, [])
    drone_by_id[drone_id] = drone
    foe_drones << drone
  end

  drone_scan_count = gets.to_i
  drone_scan_count.times do
    drone_id, fish_id = gets.split.map(&:to_i)
    drone_by_id[drone_id].scans.push(fish_id)
  end

  visible_fish_count = gets.to_i
  visible_fish_count.times do
    fish_id, fish_x, fish_y, fish_vx, fish_vy = gets.split.map(&:to_i)
    pos = Vector.new(fish_x, fish_y)
    speed = Vector.new(fish_vx, fish_vy)
    visible_fishes << Fish.new(fish_id, pos, speed, fish_details[fish_id])
  end

  my_radar_blip_count = gets.to_i
  my_radar_blip_count.times do
    drone_id, fish_id, dir = gets.split
    drone_id = drone_id.to_i
    my_radar_blips[drone_id] << RadarBlip.new(fish_id.to_i, dir)
  end

  my_drones.each do |drone|
    x = drone.pos.x
    y = drone.pos.y
    # TODO: Implement logic on where to move here
    target_x = 5000
    target_y = 5000
    light = 1

    puts "MOVE #{target_x} #{target_y} #{light}"
  end
end
