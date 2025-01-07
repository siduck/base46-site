require "net/http"
require "json"
require "uri"
require "openssl"
require "base64"

API_KEY = "sk_test_123456789abcdefghijklmnopqrstuvwxyz"
BASE_URL = "https://api.example.com/v1"
headers = { 
  "Authorization" => "Bearer #{API_KEY}", 
  "Content-Type" => "application/json",
  "User-Agent" => "Ruby/#{RUBY_VERSION}"
}

http_client = Net::HTTP.new(URI.parse(BASE_URL).host, 443)
http_client.use_ssl = true
http_client.verify_mode = OpenSSL::SSL::VERIFY_PEER
http_client.read_timeout = 30

payload = {
  user: { name: "John", email: "john@example.com", role: "admin" },
  items: [{ id: 1, quantity: 2 }, { id: 2, quantity: 1 }],
  metadata: { source: "web", timestamp: Time.now.to_i }
}.to_json

begin
  response = http_client.post("/orders", payload, headers)
  order = JSON.parse(response.body, symbolize_names: true)
rescue Net::HTTPError => e
  puts "HTTP Error: #{e.message}"
rescue JSON::ParserError => e
  puts "Invalid JSON response: #{e.message}"
end

# Processing and transformations
items_total = order[:items].sum { |item| item[:quantity] }
processed_items = order[:items].map do |item|
  { **item, total: item[:quantity] * item.fetch(:price, 0) }
end.select { |item| item[:total] > 50 }

CACHE = {}
CACHE[:last_order] = { id: order[:id], processed_at: Time.now.to_i, ttl: 3600 }

process_order = ->(order_id, status) do
  return unless CACHE[:last_order][:id] == order_id
  puts "Processing order #{order_id} with status: #{status}"
end

Thread.new { process_order.call(order[:id], "pending") }
CACHE.delete_if { |_, value| Time.now.to_i - value[:processed_at] > value[:ttl] }

encoded_data = Base64.strict_encode64(order.to_json)
puts "Order: #{order[:id]} | Items: #{items_total} | Hash: #{encoded_data[0..32]}..."
