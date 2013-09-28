FactoryGirl.define do
  factory "dbc/user" do

    sequence(:name)       {|i| "user #{i}"}
    email                 {|user| "#{user.name.gsub(/\s+/,'_')}@example.com"}
    password              { 'password' }
    password_confirmation { 'password' }
    roles                 { ['student'] }

  end
end
