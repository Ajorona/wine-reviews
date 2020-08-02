# The data can then be loaded with the rails db:seed

require 'pg'
require 'csv'
require 'logger'

WINE_DATA_FILE = 'db/winemag-data-130k-v2.csv'
wine_data = CSV.parse(File.read(WINE_DATA_FILE), headers: true)


wine_data.each do |row|
  # 1: To insert a review, title, description, and country are necessary at minimum
  if row.field("title").present? && row.field("description").present? && row.field("country").present? && Country.exists?(name: row.field("country").upcase)
    country = Country.find_by!(name: row.field("country").upcase)

    # 2: GET OR INSERT TASTER
    taster = nil
    if row.field("taster_name").present?
      # a: get taster if already exists 
      taster = Taster.find_by(name: row.field("taster_name").downcase)
      # b: else insert taster
      if !taster 
        taster = Taster.create(
          {
            name: row.field("taster_name").downcase,
            twitter: row.field("taster_twitter_handle")
          }
        )
      end
    end

    # 2 GET OR INSERT VARIETY
    variety = nil
    if row.field("variety").present?
      # a: get variety if already exists 
      variety = Variety.find_by(name: row.field("variety").downcase)

      # b: else insert variety
      if !variety
        variety = Variety.create({name: row.field("variety").downcase})
      end
    end

    # 3: GET OR INSERT LOCATIONS
    location = nil
    exists_province = row.field("province").present?
    exists_region_1 = row.field("region_1").present?
    exists_region_2 = row.field("region_2").present?

    # a: region_2 exists
    if exists_region_2
      # i: region_2 has a parent region and parent province
      if exists_region_1 && exists_province
        parent_province = Location.find_by(name: row.field("province").downcase)
        parent_region_1 = Location.find_by(name: row.field("region_1").downcase)

        parent_province = parent_province ? parent_province : Location.create({name: row.field("province").downcase})
        parent_region_1 = parent_region_1 ? parent_region_1 : Location.create({name: row.field("region_1").downcase, parent_location_id: parent_province.id})

        location = Location.create({name: row.field("region_2").downcase, parent_location_id: parent_region_1.id})
      # ii: region 2 only has a parent region
      elsif exists_region_1
        parent_region_1 = Location.find_by(name: row.field("region_1").downcase)
        parent_region_1 = parent_region_1 ? parent_region_1 : Location.create({name: row.field("region_1").downcase})

        location = Location.create({name: row.field("region_2").downcase, parent_location_id: parent_region_1.id})
      # iii: region 2 has only a parent province
      elsif exists_province
        parent_province = Location.find_by(name: row.field("province").downcase)
        parent_province = parent_province ? parent_province : Location.create({name: row.field("province").downcase})
      
        location = Location.create({name: row.field("region_2").downcase, parent_location_id: parent_province.id})
      # iv: region 2 has neither a parent region nor parent province
      else
        location = Location.create({name: row.field("region_2").downcase})
      end
    # b: region_1 and not region_2
    elsif exists_region_1
      # i: region_1 has a parent province
      if exists_province
        parent_province = Location.find_by(name: row.field("province").downcase)
        parent_province = parent_province ? parent_province : Location.create({name: row.field("province").downcase})

        location = Location.create({name: row.field("region_1").downcase, parent_location_id: parent_province.id})
      # ii: region_1 does not have a parent province
      else
        location = Location.find_by(name: row.field("region_1").downcase)
        location = location ? location : Location.create({name: row.field("region_1").downcase})
      end
    # b: province and not region_1 nor region_2
    elsif exists_province
        location = Location.find_by(name: row.field("province").downcase)
        location = location ? location : Location.create({name: row.field("province").downcase})
    end

    # 5: Attempt to create winery
    if row.field("winery").present?
      winery = Winery.find_by(name: row.field("winery").downcase)
      winery = winery ? winery : Winery.create({name: row.field("winery").downcase, locations_id: location.id})

      # 6: Attempt to create designation
      if row.field("designation").present?
        designation = Designation.find_by(name: row.field("designation").downcase)
        designation = designation ? designation : Designation.create({name: row.field("designation").downcase, wineries_id: winery.id})
      end
    end

    # 7: CREATE WINE
    wine = Wines.find_by(name: row.field("title").downcase)
    wine = wine ? wine : Wines.create(
      {
        name: row.field("title").downcase,
        wineries_id: winery ? winery.id : nil, 
        varieties_id: variety ? variety.id : nil,
        designations_id: designation ? designation.id : nil
      }
    )

    # 8: CREATE REVIEW
    review = Review.create(
      {
        description: row.field("description"),
        points: row.field("points"),
        price: row.field("price"),
        wines_id: wine ? wine.id : nil,
        tasters_id: taster ? taster.id : nil
      }
    ) 
  end
end