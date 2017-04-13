def get_meeting_rooms_with_equipment(req_equipments, meeting_rooms)
  mrs = []
  meeting_rooms.each do |mr|
    puts "Meeting room: #{mr.name}"
    puts "Equipments: #{mr.equipments.ids}"
    mr.equipments.each do |e|
      puts "e: #{e}"
      puts e.id
      if req_equipments.include?(e.id)
        mrs << mr
      end
    end
  end
  mrs.uniq
end


building = Building.last
mrooms = building.meeting_rooms
req_eq = [2,5]
mrs = get_meeting_rooms_with_equipment(req_eq, mrooms)
puts "Building #{building.name} Meeting Rooms with equipments #{req_eq}"
mrs.each { |m| puts "#{m.id} : #{m.name}" } 
puts "#{mrs.uniq.size}"
