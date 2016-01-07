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

# Quick building the site

Building the website requires [Racket][1] and [frog][2].
If you have Racket installed (and in your build path), you can install
frog by typing:

```
raco pkg install frog
```

To build the webiste, run:

```
racket make.rkt
```

If you have push access to the `origin` branch in your repo, you can
deploy the website by running:

```
racket make.rkt -d
```

# Development

If you planning on developing this website, we recommend you install
this repo as a package.
This makes sure you have the dependencies to build the website.

To do this, cd into this directory and type:

```
raco pkg install -n nanopass-github-io
```

[1]: http://racket-lang.org
[2]: https://github.com/greghendershott/frog
