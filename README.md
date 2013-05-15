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


