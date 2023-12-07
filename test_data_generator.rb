require 'faker'
require 'csv'

class TestDataGenerator
  def initialize
    @data = []
  end

  def generate_user
    {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      age: Faker::Number.between(from: 18, to: 99)
    }
  end

  def generate_product
    {
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price
    }
  end

  def generate_data_package
    user_data = generate_user
    product_data = generate_product
    {
      'User Name' => user_data[:name],
      'Email' => user_data[:email],
      'Age' => user_data[:age],
      'Product Name' => product_data[:name],
      'Price' => product_data[:price]
    }
  end

  def generate_and_save_data_packages(file_path)
    puts "Enter the number of data packages to generate:"
    num_packages = gets.chomp.to_i

    num_packages.times do
      @data << generate_data_package
    end

    save_to_csv(file_path)
  end

  def save_to_csv(file_path)
    CSV.open(file_path, 'w') do |csv|
      csv << ['User Name', 'Email', 'Age', 'Product Name', 'Price']
      @data.each do |package|
        csv << [package['User Name'], package['Email'], package['Age'], package['Product Name'], package['Price']]
      end
    end
  end
end

