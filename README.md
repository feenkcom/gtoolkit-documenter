# GToolkit Documenter
The GToolkit Documenter is the tool for creating and consuming live documents directly in the development environment. It is part of the [Glamorous Toolkit project](https://github.com/feenkcom/gtoolkit). It exploits the [Bloc project](https://github.com/pharo-graphics/Bloc) for rendering, and the [Pillar project](https://github.com/pillar-markup/pillar) for the markup language.

At its core it offers a live editor for manipulating Pillar documents. The interaction happens seamlessly directly in the text editor, and it can be combined with different types of previews to serve several classes of use cases:
- documentation of existing code
- interactive data notebook
- tutorials

## Documentation of existing code

<blockquote class="twitter-tweet" data-partner="tweetdeck"><p lang="en" dir="ltr">The preview of code snippets execution can be resized as well in <a href="https://twitter.com/hashtag/gtoolkit?src=hash&amp;ref_src=twsrc%5Etfw">#gtoolkit</a> Documenter. <a href="https://t.co/BnoP4D5O3f">pic.twitter.com/BnoP4D5O3f</a></p>&mdash; feenk (@feenkcom) <a href="https://twitter.com/feenkcom/status/1002851190475026432?ref_src=twsrc%5Etfw">June 2, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


![Documenter: expanded pictures](./doc/gt-documenter-epicea-diff.gif)

For example, Documenter can embed pictures right in place:

![Documenter: expanded pictures](./doc/documenter-mondrian-example-pictures.png)

And it can even embed live code that can be previewed in place:

![Documenter: expanded examples](./doc/documenter-mondrian-expanded-examples.png)


You can see a live example of documentation by inspecting the following snippet:
```
GtDocumenter editorForText: BrToggleExamples comment. 
```

## Tutorials

```
IceRepository repositoriesLocation / 'feenkcom'/ 'gtoolkit-examples' / 'doc' / 'tutorial' / 'examples-tutorial.pillar'. 
```

```
IceRepository repositoriesLocation / 'feenkcom'/ 'gtoolkit-documenter' / 'doc' / 'beacon' / 'index.pillar'. 
```

## Interactive data notebook


## How to load

The ideal way to load the code is by loading the entire [Glamorous Toolkit code](https://github.com/feenkcom/gtoolkit). However, you can load the Documenter code in Pharo 6.1 using the following snippet:

```
Metacello new
   baseline: 'GToolkitDocumenter';
   repository: 'github://feenkcom/gtoolkit-documenter/src';
   load.
```
