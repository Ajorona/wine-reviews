
json.id detailed_result['id']
json.points detailed_result['review'].points
json.price detailed_result['review'].price
json.description detailed_result['review'].description

json.partial! detailed_result['wine'], partial 'wine', as :wine

if detailed_result.key?('winery')
  json.partial! detailed_result['winery'], partial 'winery' , as :winery
end

if detailed_result.key?('reviewer')
  json.partial! detailed_result['reviewer'], partial 'reviewer' , as :reviewer
end

if detailed_result.key?('variety')
  json.partial! detailed_result['variety'], partial 'variety' , as :variety
end