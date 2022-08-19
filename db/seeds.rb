if Rails.env.development?
  User.create!(email: 'admin@mail.com', password: '12345678', first_name: 'David',
               role: User.roles[:admin])
  User.create!(email: 'expert1@mail.com', password: '12345678', first_name: 'Benjamín',
               role: User.roles[:expert])
  User.create!(email: 'expert2@mail.com', password: '12345678', first_name: 'Bárbara',
               role: User.roles[:expert])
  User.create!(email: 'expert3@mail.com', password: '12345678', first_name: 'Ernesto',
               role: User.roles[:expert])
  client_one = User.create!(email: 'client1@mail.com', password: '12345678', first_name: 'Oscar',
                            role: User.roles[:client])
  client_two = User.create!(email: 'client2@mail.com', password: '12345678', first_name: 'Oscar',
                            role: User.roles[:client])
  contract_one = Contract.create!(name: 'Recorrido 1',
                                  start_date: '2022-08-12',
                                  end_date: '2022-08-31',
                                  start_wday: 2,
                                  start_hour: '6:00',
                                  end_hour: '16:00',
                                  end_wday: 6,
                                  requested_by_id: client_one.id)
  contract_two = Contract.create!(name: 'Recorrido 2',
                                  start_date: '2022-08-15',
                                  end_date: '2022-08-31',
                                  start_wday: 0,
                                  start_hour: '8:00',
                                  end_hour: '19:00',
                                  end_wday: 6,
                                  requested_by_id: client_two.id)
  contract_one.update!(accepted_by_id: User.where(role: 1).first.id,
                       state: Contract.states[:accepted])
  contract_two.update!(accepted_by_id: User.where(role: 1).first.id,
                       state: Contract.states[:accepted])
end
Setting.create_or_find_by!(key: 'min_version', value: '0.0')
