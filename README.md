Nanopass Website
================

Due to a limitation in how Github Pages works, development for this
repo happens on the `source` branch. Once cloned, run:

```
git checkout source
```

To get the latest build.

If you develop on `master` your changes will be stomped the next time
the site is deployed.

# Building the site

Building the website requires [Racket][1].

To build the webiste, run:

```
racket make.rkt
```

If you have push access to the `origin` branch in your repo, you can
deploy the website by running:

```
racket make.rkt -d
```

[1]: http://racket-lang.org
