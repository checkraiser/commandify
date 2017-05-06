module Common
  module Faker
    def random_email
      ::Faker::Internet.email
    end

    def random_name
      ::Faker::Name.name
    end

    def random_first_name
      ::Faker::Name.first_name
    end

    def random_last_name
      ::Faker::Name.last_name
    end
  end
end
