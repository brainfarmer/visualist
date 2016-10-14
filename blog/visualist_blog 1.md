# Visualist Blog Notes

# Getting started

Create an umbrella project so we can have multiple applications managed by supervision trees.

`> mix new visualist --umbrella `


## Minimal Phoenix components


We don't need every component of the Phoenix framework, though there are some pieces that we want to leverage.


`>mix phoenix.new web --no-brunch --no-ecto --module Visualist.Web`

This produces a stripped Phoenix of only essential components. 

The apps/web directory is slim and trim containing usefult constructs of Phoenix like controllers, views, channels and routing.

```
visualist develop % ls -al ./apps/web/web
total 24
drwxr-xr-x  11 jszodfridt  staff   374 Aug 12 15:52 .
drwxr-xr-x  10 jszodfridt  staff   340 Aug 12 15:52 ..
drwxr-xr-x   3 jszodfridt  staff   102 Aug 12 15:52 channels
drwxr-xr-x   3 jszodfridt  staff   102 Aug 12 15:52 controllers
-rw-r--r--   1 jszodfridt  staff   708 Aug 12 15:52 gettext.ex
drwxr-xr-x   2 jszodfridt  staff    68 Aug 12 15:52 models
-rw-r--r--   1 jszodfridt  staff   537 Aug 12 15:52 router.ex
drwxr-xr-x   3 jszodfridt  staff   102 Aug 12 15:52 static
drwxr-xr-x   4 jszodfridt  staff   136 Aug 12 15:52 templates
drwxr-xr-x   6 jszodfridt  staff   204 Aug 12 15:52 views
-rw-r--r--   1 jszodfridt  staff  1533 Aug 12 15:52 web.ex
```


The dependencies are centralized in the root directory and again are only a few things that provide essentials like web server (cowboy), http wrapper (poison) etc.

```
visualist develop % ls -al ./deps
total 0
drwxr-xr-x  13 jszodfridt  staff  442 Aug 12 15:52 .
drwxr-xr-x  13 jszodfridt  staff  442 Aug 12 15:52 ..
drwxr-xr-x  11 jszodfridt  staff  374 Aug 12 15:52 cowboy
drwxr-xr-x  10 jszodfridt  staff  340 Aug 12 15:52 cowlib
drwxr-xr-x  12 jszodfridt  staff  408 Aug 12 15:52 fs
drwxr-xr-x   9 jszodfridt  staff  306 Aug 12 15:52 gettext
drwxr-xr-x   8 jszodfridt  staff  272 Aug 12 15:52 mime
drwxr-xr-x  14 jszodfridt  staff  476 Aug 12 15:52 phoenix
drwxr-xr-x  13 jszodfridt  staff  442 Aug 12 15:52 phoenix_html
drwxr-xr-x   9 jszodfridt  staff  306 Aug 12 15:52 phoenix_live_reload
drwxr-xr-x   9 jszodfridt  staff  306 Aug 12 15:52 plug
drwxr-xr-x  10 jszodfridt  staff  340 Aug 12 15:52 poison
drwxr-xr-x   9 jszodfridt  staff  306 Aug 12 15:52 ranch
```




