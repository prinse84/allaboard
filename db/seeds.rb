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
ReviewerType.create(name:'Not Affliated')