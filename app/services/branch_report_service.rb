class BranchReportService
  def initialize(branch, start_date = nil, end_date = nil)
    @branch = branch
    @start_date = start_date || 1.month.ago.beginning_of_month
    @end_date = end_date || Date.current.end_of_month
  end
  
  def appointments_summary
    appointments = @branch.appointments
                          .where("DATE(start_time) BETWEEN ? AND ?", @start_date, @end_date)
    
    {
      total: appointments.count,
      confirmed: appointments.where(status: :confirmed).count,
      pending: appointments.where(status: :pending).count,
      canceled: appointments.where(status: :canceled).count,
      revenue: calculate_revenue(appointments.where(status: :confirmed))
    }
  end
  
  def barber_performance
    @branch.barbers.map do |barber|
      barber_appointments = barber.appointments
                                 .where(branch: @branch)
                                 .where("DATE(start_time) BETWEEN ? AND ?", @start_date, @end_date)
      
      {
        barber: barber,
        total_appointments: barber_appointments.count,
        confirmed_appointments: barber_appointments.where(status: :confirmed).count,
        revenue: calculate_revenue(barber_appointments.where(status: :confirmed))
      }
    end
  end
  
  def popular_treatments
    Treatment.joins(:appointments)
             .where(appointments: { 
               branch: @branch, 
               status: :confirmed
             })
             .where("DATE(appointments.start_time) BETWEEN ? AND ?", @start_date, @end_date)
             .group(:name)
             .count
             .sort_by { |_, count| -count }
  end
  
  private
  
  def calculate_revenue(appointments)
    appointments.joins(:treatment).sum(:price)
  end
end