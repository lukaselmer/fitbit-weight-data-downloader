# Fitbit Weight Data Downloader

Download your fitbit weight data (e.g. form your aria fitbit) to a JSON file.

## Usage

Get you OAuth Token from the tutorial page:

* <https://dev.fitbit.com/apps>
* Go to your app (or create a new app)
* Click "OAuth 2.0 tutorial page"
* Do everything until you get the "OAuth 2.0 Access Token" (also named bearer token)

Adjust year and month as needed, and then run

```sh
OAUTH_TOKEN=xxxxxx ruby generate.rb
```

which will download all years and store them in data/#{year}.json, and finally combine them all into one JSON file.
