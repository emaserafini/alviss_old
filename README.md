# create
curl -v alviss.dev/api/feeds/1/data_temperatures -X POST \
     -H "Accept: application/json" \
     -H "Content-Type: application/json" \
     -d '{"data_temperature": {"value": 20}}'

curl -v localhost:3000/api/feeds/1/data_temperatures -X POST \
     -H "Accept: application/json" \
     -H "Content-Type: application/json" \
     -d '{"data_temperature": {"value": 20}}'

# index
curl -v alviss.dev/api/temperatures

# show
curl -v alviss.dev/api/temperatures/1

# update


# look out

"Need to return JSON-formatted 404 error in Rails"
http://stackoverflow.com/questions/10253366/need-to-return-json-formatted-404-error-in-rails

"Building a RESTful API in a Rails Application"
https://www.airpair.com/ruby-on-rails/posts/building-a-restful-api-in-a-rails-application
