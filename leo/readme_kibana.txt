How to set up Kibana:
- Go to Kibana Dev-Mode
- Insert the content of put_leo.json and execute it.
- execute leocurl_json.sh to fill some data into kibana
- Create Indexpattern for leo*
- Export that pattern and search for the ID
- Edit tokenviews.ndsjon and replace the Ref-ID with the new Indexpattern-ID
- Import that file into Kibana
- Adjust the new dashboard with the new views

More Details see: https://github.com/achimmertens/HiveTokenELK#readme
