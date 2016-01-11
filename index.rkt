#lang scribble/html

@require["templates.rkt"
         "logos/icon.rkt"]

@page[#:title "Home"]{
  @div[class: "jumbotron"]{
    @div[class: "container"]{
      @div[class: "splash"]{
        @center[@img[src: big-banner alt: "Nanopass logo" height: "130" width: "600"]]
        @h2{Clean Compiler Creation Language}
        @p{@b{The Nanopass Framework} is an embedded domain specific
          for creating compilers that focuses on creating small passes
          and many intermediate representations.
          Nanopass reduces the boilerplate required to create
          compilers making them easier to understand and maintain.}}
      @center{@a[class: "btn-oval btn btn-default btn-lg" href: "http://github.com/nanopass" role: "button"]{Get Started}}}}}
