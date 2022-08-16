if Rails.env.development?
  User.create!(email: 'admin@mail.com', password: '12345678', role: User.roles[:admin])
  User.create!(email: 'expert@mail.com', password: '12345678', role: User.roles[:expert])
  User.create!(email: 'client@mail.com', password: '12345678', role: User.roles[:client])
  contract = Contract.create!(name: 'Mi empresita prueba',
                              start_date: '2022-08-12',
                              end_date: '2022-08-31',
                              start_wday: 2,
                              start_hour: '6:00',
                              end_hour: '15:00',
                              end_wday: 6,
                              requested_by_id: User.where(role: 2).first.id)
  contract.update!(accepted_by_id: User.where(role: 1).first.id, state: Contract.states[:accepted])
end
Setting.create_or_find_by!(key: 'min_version', value: '0.0')
