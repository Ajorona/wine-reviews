require 'pg'
require 'csv'
require 'yaml'
require 'logger'
require 'active_record'

BATCH_SIZE     = 1000
DB_CONFIG_FILE = '../../config/database.yml'
WINE_DATA_FILE = 'winemag-data-130k-v2.csv'

db_config = YAML.load_file(DB_CONFIG_FILE)
wine_data = CSV.parse(File.read(WINE_DATA_FILE), headers: true)


csv_to_db_map = {
  "country": "country",                     # 0
  "description": "description",             # 1
  "designation": "designation",             # 2
  "points": "points",                       # 3
  "price": "price",                         # 4
  "province": "province",                   # 5
  "region_1": "region",                     # 6
  "region_2": "subregion",                  # 7
  "taster_name": "taster",                  # 8
  "taster_twitter_handle": "taster_handle", # 9
  "title": "name",                          # 10
  "variety": "variety",                     # 11
  "winery": "winery"                        # 12
}

 
puts wine_data[0]


ActiveRecord::Base.establish_connection(
  :adapter => "postgresql", :username => db_config["username"],
    :password => db_config["password"], :database => db_config["database"]
)


def init_logger(path)
  File.new(path, "w")
  $LOG = Logger.new(path)
end

# 1 Attempt to insert taster
$LOG = init_logger("logs/tasters.log")

# 2 Attempt to insert variety
$LOG = init_logger('logs/varieties.log')

# 3 Validate Country in valid countries
$LOG = init_logger("logs/countries.log")

# 4 Attempt to create location
$LOG = init_logger("logs/locations.log")

# 5 Attempt to create winery
$LOG = init_logger("logs/wineries.log")

# 6 Attempt to create designation
$LOG = init_logger("logs/designations.log")

# 7 Attempt to create wine
$LOG = init_logger("logs/wines.log")

# 8 Attempt to create review
$LOG = init_logger("logs/reviews.log")
