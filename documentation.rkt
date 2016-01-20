#lang scribble/html

@require["templates.rkt"]

@page[#:title "Documentation"]{
  @div[class: "jumbotron"]{
    @div[class: "container"]{
      @h1{Documentation}}}
  @div[class: "container"]{
    @div[class: "row"]{
      @div[class: "col-md-4 blurb"]{
        @h2{@a[href: "http://pkg-build.racket-lang.org/doc/nanopass/index.html"]{User Guide}}
        @p{Detailed documentation on Nanopass.}}
      @div[class: "col-md-4 blurb"]{
        @h2{@a[href: "http://github.com/nanopass/"]{Sample Compilers}}
        @p{Examples of Compilers that were created using Nanopass.}}
      @div[class: "col-md-4 blurb"]{
        @h2{@a[href: "https://www.youtube.com/watch?v=Os7FE3J-U5Q"]{Writing a Nanopass Compiler Video}}
        @p{Andy Keep discuss writing a Scheme to C compiler using Nanopss, given at Clojure/Conj 2013}}}}
  @div[class: "container"]{
    @h1{Papers}
    @ul{
      @li{@a[href: "http://andykeep.com/pubs/dissertation.pdf"]{A Nanopass Framework For Commercial Compiler Development},
        PhD Thesis for Andy Keep.}
      @li{@a[href: "http://www.cs.indiana.edu/~dyb/pubs/nano-jfp.pdf"]{A Nanopass Framework for Compiler Education}, Dipanwita Sarkar, Oscar Waddell, R. Kent Dybvig}}}}
