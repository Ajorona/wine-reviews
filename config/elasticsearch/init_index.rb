
index_settings = { 
	number_of_shards: 1,
	number_of_replicas: 0,
	"analysis": {
	  "analyzer": {
	    "ngram_analyzer": {
	      "tokenizer": "ngram_tokenizer"
	    },
	    "standard_asciifolding": {
	      "tokenizer": "standard",
	      "filter": [ "asciifolding" ]
	    }
	  },
	  "tokenizer": {
	    "ngram_tokenizer": {
	      "type": "ngram",
	      "min_gram": 2,
	      "max_gram": 2,
	      "token_chars": [
	        "letter",
	        "digit"
	      ]
	    }
	  }
	}
}

settings = { settings: { index: index_settings } }
SearchClient.indices.create(index: "reviews", body: settings)

MAPPINGS = JSON.parse(File.read("config/elasticsearch/mappings/reviews.json"), symbolize_names: true).freeze
SearchClient.indices.put_mapping(index: "reviews", body: MAPPINGS)
