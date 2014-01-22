# Playtest

Playtest is a Ruby system for generating a PDF suitable for playtesting and prototyping physical card games.

## Installing Playtest

1. Pull playtest down from GitHub
2. Run ``bundle install`` to install the gems we depend on
3. Run ``ruby playtest.rb`` to start the script and make sure it completes successfully

## Using Playtest

A cards.yml file is used to store the contents of the cards you wish to create. You can specify the quantity in addition to information like the card name, rules text and cost. If you want to add additional properties to the cards.yml file, that's possible, but you'll need to modify the code so that it renders where and how you want it to.

After running, exported files are saved in ``export/``. You may wish to copy the files generated here elsewhere so they do not get rewritten.

## Command Line Interface

We've recently added some command line options to give you greater control over the cards you generate:

# CLI Options

-v | --verbose : display console output while running

-c CARDYAML | --cards CARDYAML : defaults to "import/cards.yml", the YAML file it will use for reference

-o OUTPUT | --output OUTPUT : the file to export to. Defaults to "export/rendered_XXXXXX.ext" where XXXX is the microtime and ext is the output extension (defaults to PDF)

-s CSSFILE | --stylesheet CSSFILE : The css file to use when doing HTML output, optional. Defaults to "import/default.css"

# CLI Examples

Super basic: ./playtest.rb

Super basic, verbose: ./playtest.rb -v

Custom YAML input: ./playtest.rb -c "import/cards.yml"

HTML output: ./playtest.rb -o "export/foo.html"

Super tweaked: ./playtest.rb -v -c "/path/to/my/cards.yml" -o "/path/to/my/export/new_cards.pdf"

## Contributing to Playtest

To add new code please:

1. Fork playtest
2. Write your code
3. Make sure the tests are pssing using rspec
4. Submit a pull request

To report an issue or request a feature, please use our handy [issue tracker](http://github.com/jburdeezy/playtest/issues)

## Contributors

My thanks to @diachini and @armahillo for being contributors to the project.
