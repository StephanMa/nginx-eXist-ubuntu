nginx-eXist-ubuntu
==================

Nginx as a reverse proxy and cache server for the eXist-db Application Server

eXist-db provides a XML document-oriented schema-less data-store and an xQuery engine to access and serve this data. Included are the files and scripts I have used to set up a development and production servers for serving multiple web-site domains.



Nginx The Web Server, Exist The XML Application Server
-----------------------------------------------------

The eXist application server is
[proxied behind](http://exist-db.org/exist/apps/doc/production_web_proxying.xml)
a nginx web server. We do this

1. for access control security reasons. With Nginx we have a degree of control over the URLs served.
2. for speed reasons.  By the proxy caching and serving frequently-accessed static content we can get a happier clients.




Install Nginx
----------------
Nginx can be easily be compiled and installed from source.
In the 'install' folder is the bash script 'nginx-install.sh'
which will do the install. Remember to make it executable first.
```chmod +x nginx-install.sh``` then run as sudo ``` ./nginx-install.sh```.
By default, Nginx will be installed in '/usr/local/nginx'.



Upstart Nginx
-------------
To start/stop Nginx and start on boot we use [http://upstart.ubuntu.com/](upstart.)
Provided in the upstart folder is the upstart nginx.conf and the associated bash script
which will copy nginx.conf to /etc/init/

Once installed nginx will start on boot and
you can start Nginx as sudo with the simple command
```start nginx``` and
```stop nginx``` will stop nginx



Nginx configuration
-------------------

We have 2 server environments therefore 2 different Nginx configurations

1. A development environment.

2. A production environment.

**Assumptions**:
 Your website domain names become the app collection names for eXist-db applications.
 e.g. For the domain 'markup.co.nz' when starting a
 [New Application in eXide](http://exist-db.org/exist/apps/doc/development-starter.xml)
 the 'target collection' will be 'markup.co.nz'.

 When locally developing the web-site ```sudo gedit /etc/hosts```
 and add entries so your domain names resolve to local-host e.g.
 ```127.0.0.1        markup.co.nz```
 If you want to browse your remote production server you can comment this out or
 surf using the WWW prefix e.g. http://WWW.markup.co.nz


**Requirements**:
 For both server and production environments we want our Nginx configuration.

1. To handle multiple 'domains' without reference to the actual domain. We have a dynamic 'server name', based on the
'domain name', which generates the $domain variable. ```server_name  ~^(www\.)?(?<domain>.+)$;``` Multiple site domains or sub-domains can be served without changing the nginx configuration.
2. To be file extension agnostic.  ref: [extension-less-url-the-best-practice-that-time-forgot](http://WWW.codingthewheel.com/archives/extension-less-url-the-best-practice-that-time-forgot/)
 and the  classic
[Cool URIs don't change](http://WWW.w3.org/Provider/Style/URI).
Link to this page  '[http://markup.co.nz/articles/nginx-as-reverse-proxy-for-eXist]' requires no 'html' extension.
With Nginx rewrites
  1. http://markup.co.nz    //should land at the home page
  2. http://markup.co.nz/   //should land at the  home page
  3. http://markup.co.nz/index ///should land at the  home page
  4. http://markup.co.nz/index.html  //should land at the home page
  5. http://markup.co.nz/articles //should land at  at the {collection}.index page
  6. http://markup.co.nz/articles/ //should land at  at the  {collection}.index page
  7. http://markup.co.nz/articles/index.html  //should land at the {collection}.index page
  8. http://markup.co.nz/articles/nginx-as-reverse-proxy-for-eXist  //should land at {collection}/{resource} page
  9. http://markup.co.nz/articles/nginx-as-reverse-proxy-for-eXist.html should land at {collection}/{resource} page
3. To be Cookie-less. Nginx just ignores Jetty generated cookies. As cookies 'are difficult to cache, and are not needed in most situations'
4.  Nginx excels at serving files of the disk, so all resources, styles, scripts, images are handled directly by Nginx bypassing eXist. All images etc are stored in the eXist...data/fs directory so our Nginx server root is '/usr/local/eXist/webapp/WEB-INF/data/fs/db/apps/$domain'.
and Nginx will look for our files there.


5. [gZip](https://en.wikipedia.org/wiki/Gzip) compression of styles and scripts files when the browser sends a header
telling the server it accepts compressed content ``'Accept-Encoding: gzip, deflate'``.  On the fly compression can be
done but also used is  the Nginx setting ``gzip_static on``; which serves gZipped files directly from disk if available.


**Requirements**:
For our development server

1. We do not want the browser caching our constantly changing scripts and style-sheets.
2. We do not want the Nginx acting as a Proxy cache cause we want to see our updated content immediately

**Requirements**:
For our development server

1. We want to maximize browser caching. We want the nginx server to tell the browser what to cache with the use of the associated headers for our static content. http://www.slideshare.net/rosstuck/http-and-your-angry-dog
  1. Expires header set in the future
  2. [Cache]( http://www.mnot.net/cache_docs/ ) Control on served images and scripts. ```Cache-Control: max-age```
  3. ETag & Last Modified set for static content: images and css
  4. Content Length header set
  5. We want our server's clock to be accurate other setting header timestamps won't work as expected.
  To check if your server's clock is correct. go to [redbot](http://redbot.org/?uri=http%3A%2F%2Fwww.markup.co.nz) and enter your sites URL.
  *Note*:  If note correct ssh into your server and try using ntpdate to fetch from a closer local pool. eg.
  ```ntpdate nz.pool.ntp.org```

2. We want to Nginx to act as proxy cache for content initally generated from eXist. If our content does not need to be refreshed every time the page is visited then Nginx can cache the page for a set time and serve the cached page instead of behaving as a reverse proxy for eXist. When the set time expires then Nginx will again act as a reverse proxy for eXist return in a fresh page from eXist. The fresh page will also be cached by Nginx an so Nginx will start to again serve from its cache.

