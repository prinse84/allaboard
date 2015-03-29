# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ReviewerType.create(name:'Current member')
ReviewerType.create(name:'Former member')
ReviewerType.create(name:'Staff Liaison')
ReviewerType.create(name:'Volunteer')
Period.create(name:'Monthly')
Period.create(name:'Bi-Monthly')
Period.create(name:'Quarterly')
Period.create(name:'Semi-Annually')
Period.create(name:'Annually')
Period.create(name:'Other')
MembershipSize.create(name:'1-5')
MembershipSize.create(name:'6-20')
MembershipSize.create(name:'20+')
