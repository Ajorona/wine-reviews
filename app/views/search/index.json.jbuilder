json.array! @detailed_results do |detailed_result|
  json.partial! 'search/reviews', detailed_result: detailed_result
end
