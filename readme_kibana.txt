How to set up Kibana manually:
- Go to Kibana Dev-Mode
- Delete the index, insert the content of put_index.json, adjust the tokenname and execute it.
- execute leocurl_json.sh to fill some data into kibana
	or go to logfile and execute 
        curl --location --request POST 'http://localhost:9200/token/_bulk?' --header 'Content-Type: application/json' --data-binary @tokencurlcons.log
- Delete and create the index pattern for the token (i.e. *leo) and name the ID "token_index_pattern_ID" (i.e. "leo_index_pattern_ID")
- (Export that pattern and search for the ID) 
- (Edit tokenviews.ndsjon and replace the Ref-ID with the new Indexpattern-ID)
- Import the corresponding tokenview file into Kibana
- Adjust the new dashboard with the new views

More Details see: https://github.com/achimmertens/HiveTokenELK#readme
