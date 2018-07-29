# frozen_string_literal: true

if @shop.errors.empty?
  json.data do
    json.shop do
      json.partial! 'shops', shop: @shop
    end
  end
else
  json.errors ErrorSerializer.serialize(@shop.errors)
end
