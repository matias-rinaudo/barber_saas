class BarberAvailabilityService
  def initialize(barber)
    @barber = barber
  end
  
  # Obtener horarios disponibles para un barbero en una sucursal específica
  def available_slots(branch, date)
    return [] unless @barber.works_in_branch?(branch)
    
    branch_hours = branch.working_hours || default_hours
    existing_appointments = @barber.appointments
                                  .where(branch: branch)
                                  .where("DATE(start_time) = ?", date)
                                  .pluck(:start_time, :end_time)
    
    # Lógica para calcular slots disponibles
    generate_available_slots(branch_hours, existing_appointments, date)
  end
  
  # Verificar si un barbero está disponible para una cita específica
  def available_for_appointment?(branch, date, start_datetime, end_datetime)
    return false unless @barber.works_in_branch?(branch)
    
    conflicting_appointments = @barber.appointments.where(
      branch: branch
    ).where("DATE(start_time) = ?", date)
     .where(
      "(start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?)",
      start_datetime, start_datetime, end_datetime, end_datetime
    )
    
    conflicting_appointments.empty?
  end
  
  private
  
  def default_hours
    {
      "monday" => { "open" => "09:00", "close" => "18:00" },
      "tuesday" => { "open" => "09:00", "close" => "18:00" },
      "wednesday" => { "open" => "09:00", "close" => "18:00" },
      "thursday" => { "open" => "09:00", "close" => "18:00" },
      "friday" => { "open" => "09:00", "close" => "18:00" },
      "saturday" => { "open" => "09:00", "close" => "15:00" },
      "sunday" => { "closed" => true }
    }
  end
  
  def generate_available_slots(branch_hours, existing_appointments, date)
    day_name = date.strftime("%A").downcase
    day_hours = branch_hours[day_name]
    
    return [] if day_hours.nil? || day_hours["closed"]
    
    # Implementar lógica de generación de slots
    # Este es un ejemplo básico
    slots = []
    current_time = Time.parse(day_hours["open"])
    end_time = Time.parse(day_hours["close"])
    
    while current_time < end_time
      slot_end = current_time + 30.minutes
      
      # Verificar si el slot no está ocupado
      unless slot_conflicts_with_appointments?(current_time, slot_end, existing_appointments)
        slots << {
          start_time: current_time.strftime("%H:%M"),
          end_time: slot_end.strftime("%H:%M")
        }
      end
      
      current_time += 30.minutes
    end
    
    slots
  end
  
  def slot_conflicts_with_appointments?(slot_start, slot_end, appointments)
    appointments.any? do |appt_start, appt_end|
      appt_start = Time.parse(appt_start.strftime("%H:%M"))
      appt_end = Time.parse(appt_end.strftime("%H:%M"))
      
      (slot_start < appt_end) && (slot_end > appt_start)
    end
  end
end