# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# capi = Calendarific::V2.new(ENV['CALENDARIFIC_API_KEY'])

# parameters = {
#     country: 'ph',
#     year: Date.today.year,
#     type: 'national'
# }

# response = capi.holidays(parameters)

# response['response']['holidays'].each do |holiday|
#     regular = [
#         "New Year's Day",
#         "The Day of Valor",
#         "Maundy Thursday",
#         "Good Friday",
#         "Labor Day",
#         "Independence Day",
#         "National Heroes Day",
#         "Bonifacio Day",
#         "Christmas Day",
#         "Rizal Day"    
#     ]

#     if regular.include?(holiday['name'])
#         h = Holiday.new({
#             name: holiday['name'],
#             description: holiday['description'],
#             date: Date.parse(holiday['date']['iso']),
#             kind: "Regular",
#             weekday: Date.parse(holiday['date']['iso']).strftime('%A')
#         })
#         if h.save
#             puts "Holiday #{h.name} on #{h.date} created."
#         end
#     else
#         h = Holiday.new({
#             name: holiday['name'],
#             description: holiday['description'],
#             date: Date.parse(holiday['date']['iso']),
#             kind: "Special",
#             weekday: Date.parse(holiday['date']['iso']).strftime('%A')
#         })
#         if h.save
#             puts "Holiday #{h.name} on #{h.date} created."
#         end
#     end
# end

# h = Holiday.new({
#     name: "Feast of the Immaculate Conception",
#     description: '',
#     date: Date.new(parameters[:year], 12, 8),
#     kind: "Special",
#     weekday: Date.new(parameters[:year],12,8).strftime('%A')
# })
# if h.save
#     puts "Holiday Feast of the Immaculate Conception on #{Date.new(parameters[:year], 12, 8)} created."
# end


if EmploymentStatus.all.empty?
    EmploymentStatus.create([
        {status: "Probation"},
        {status: "Regular"}, 
        {status: "Terminated"}
    ])
    puts "Created Employment Statuses."
end

if SalaryGrade.all.empty?
    SalaryGrade.create([
        {grade: "A", daily_pay: 400},
        {grade: "B", daily_pay: 450}, 
        {grade: "C", daily_pay: 500}
    ])
    puts "Created default Salary Grades."
end

if Leave.all.empty?
    Leave.create([
        {name: "Service Incentive Leave", days: 5},
        {name: "Maternity Leave", days: 60},
        {name: "Paternity Leave", days: 7},
        {name: "Solo Parent Leave", days: 7},
        {name: "VAWC Leave", days: 10}
    ])
    puts "Created different Leave types."
end