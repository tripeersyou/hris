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
#     year: 2,
#     type: 'national'
# }

# response = capi.holidays(parameters)


# puts response['response']['holidays']

# response['response']['holidays'].each do |holiday|
#     h = Holiday.new({
#         name: holiday[:name],
#         description: holiday[:description],
#         date: Date.parse(holiday[:date][:iso]),
#         type: holiday[:type][0],
#         weekday: Date.parse(holiday[:date][:iso]).strftime('%A')
#     })
#     if h.save
#         puts "#{h.name} on #{h.date} saved!"
#     end
# end


if EmploymentStatus.all.empty?
    EmploymentStatus.create([
        {status: "Probation"},
        {status: "Regular"}, 
        {status: "Terminated"}
    ])
end

if SalaryGrade.all.empty?
    SalaryGrade.create([
        {grade: "A", daily_pay: 400},
        {grade: "B", daily_pay: 450}, 
        {grade: "C", daily_pay: 500}
    ])
end