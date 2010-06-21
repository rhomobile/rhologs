rhologs
=======

Simple sinatra app which stores rhodes log files in S3.

Running
=======
1. Set the following environment variables:

AMAZON_ACCESS_KEY_ID=<mykey>
AMAZON_SECRET_ACCESS_KEY=<mysecretkey>
	
2. ruby app.rb

3. Open http://localhost:4567/ in a browser to view logs.  Use 'http://localhost:4567' in your rhoconfig.txt logserver setting.
