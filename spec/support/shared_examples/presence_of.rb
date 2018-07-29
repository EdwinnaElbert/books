# frozen_string_literal: true

# shared_examples_for 'has presence_of validation' do |params|
#   describe 'check presence_of' do
#     it 'makes new and checks presence_of' do
#
#       params.each do |key, value|
#         params[key] = nil
#         entity = described_class.new(params)
#         params[key] = value
#
#         expect(entity).to_not be_valid
#       end
#     end
#   end
# end
