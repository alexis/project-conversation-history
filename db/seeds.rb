user_1 = User.find_or_create_by!(name: "Leonard Hofstadter")
user_2 = User.find_or_create_by!(name: "Sheldon Cooper")
user_3 = User.find_or_create_by!(name: "Penny Hofstadter")

project_1 = Project.find_or_create_by!(name: "Sample Project 1", status: 'in_progress')
project_1.users << user_1 unless project_1.users.include?(user_1)
project_1.users << user_2 unless project_1.users.include?(user_2)

project_2 = Project.find_or_create_by!(name: "Sample Project 2", status: 'in_progress')
project_2.users << user_1 unless project_2.users.include?(user_1)
project_2.users << user_3 unless project_2.users.include?(user_3)
