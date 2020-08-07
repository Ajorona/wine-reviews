
json.id detailed_result['review'].id
json.points detailed_result['review'].points
json.price detailed_result['review'].price
json.description detailed_result['review'].description

json.partial! 'search/wine', wine: detailed_result['wine']

if detailed_result.key?('winery')
  json.partial! 'search/winery', winery: detailed_result['winery']
end

if detailed_result.key?('reviewer')
  json.partial! 'search/reviewer', reviewer: detailed_result['reviewer']
end

if detailed_result.key?('variety')
  json.partial! 'search/variety', variety: detailed_result['variety']
end