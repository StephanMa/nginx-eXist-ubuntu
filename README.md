nginx-eXist-ubuntu
==================

Nginx as a reverse proxy and cache server for the eXist-db Application Server

eXist-db provides a XML document-oriented schema-less data-store and an xQuery engine to access and serve this data. Included are the files and scripts I have used to set up a development and production servers for serving multiple web-sites from the eXist-db.



Nginx The Web Server, Exist The XML Application Server
-----------------------------------------------------

The eXist application server is
[proxied behind](http://exist-db.org/exist/apps/doc/production_web_proxying.xml)
a nginx web server. We do this

1. for access controll security reasons. With Nginx we have a degree of control over the urls served.
2. for speed reasons.  By the proxy caching and serving frequently-accessed static content we can get a happier clients.

We have 2 server enviroments.

1. A development enviroment.

2. A production enviroment.


Installing Nginx
----------------
Nginx can be easily be compiled and installed from source.
By default, Nginx will be installed in '/usr/local/nginx'.
In the 'install' folder is the bash script 'nginx-install.sh'
which will do the install.



Upstart Nginx
-------------

To start/stop Nginx and start on boot we use (upstart.)[http://upstart.ubuntu.com/]
Provided in the upstart folder is the upstart nginx.conf and the associatied bash script
which will copy nginx.conf to /etc/init/

Once installed nginx will start on boot and
you can start ngnix as sudo with the simple command
```start nginx``` and
```stop nginx``` will stop nginx



Nginx configuration
-------------------

Requirements For both server and production enviroments we want our Nginx configuration.


1. To handle multiple 'domains' without reference to the actual domain. We have a dynamic 'server name', based on the
'domain name', which generates the $domain variable. Multiple site domains or sub-domains can be served without changing
this script.

2. To be File extension agnostic.  ref: [extension-less-url-the-best-practice-that-time-forgot](http://www.codingthewheel.com/archives/extension-less-url-the-best-practice-that-time-forgot/)
 and the  classic
[Cool URIs don't change](http://www.w3.org/Provider/Style/URI).
Link to this page  'markup.co.nz/be/nginx' requires no 'html' extension.  Note: TODO, I think I have another way of doing this,
which I will try.
  1. http://markup.co.nz    //should land at the home page
  2. http://markup.co.nz/   //should land at the  home page
  3. http://markup.co.nz/index ///should land at the  home page
  4. http://markup.co.nz/index.html  //should land at the home page
  5. http://markup.co.nz/articles //should land at  at the {collection}.index page
  6. http://markup.co.nz/articles/ //should land at  at the  {collection}.index page
  7. http://markup.co.nz/articles/index.html  //should land at the {collection}.index page
  8. http://markup.co.nz/articles/nginx-as-reverse-proxy-for-eXist  //should land at {collection}/{resource} page
  9. http://markup.co.nz/articles/nginx-as-reverse-proxy-for-eXist.html should land at {collection}/{resource} page

3. To be Cookie-less. Ngnix just ignores Jetty generated cookies. As cookies 'are difficult to cache, and aren’t needed in most situations'

4.  Nginx excels at serving files of the disk, so all resources, styles, scripts, images are handled directly by Nginx bypassing eXist. All images etc are stored in the eXist...data/fs directory so our Nginx server root is '/usr/local/eXist/webapp/WEB-INF/data/fs/db/apps/$domain'.
and Nginx will look for our files there.


5. [gZip](https://en.wikipedia.org/wiki/Gzip) compression of styles and scripts files when the browser sends a header
telling the server it accepts compressed content ``'Accept-Encoding: gzip, deflate'``.  On the fly compression can be
done but also used is  the Ngnix setting ``gzip_static on``; which serves gZipped files directly from disk if available.
