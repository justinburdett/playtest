# Playtest

This is a simple ruby script that generates a PDF suitable for prototyping or creating print and play versions of physical card games. Great for aspiring game designers!

## Installation

Download this project and install the required dependencies by running ``bundle install``. You will also need to make sure [wkhtmltopdf](https://github.com/pdfkit/pdfkit/wiki/Installing-WKHTMLTOPDF) is installed on the machine you are using this script.

## Usage

Start the script by running ``ruby playtest.rb`` from the command line.

Card data is loaded from the ``cards.yml`` file. You'll want to customize this file to add your custom cards. You can add additional details about each card, but you'll have to update the output accordingly.

You can customize the output by updating the ``default.css`` and ``default.html`` files to your liking. The outputted PDF and HTML is exported to the ``export/`` folder.

## Known Issues

Currently, we are trying to create a flexible 3x3 grid using divs instead of our old system which successfully utilized tables. We haven't been able to successfully format the output so that cards fit all on the same page, but use our new flexible HTML layout. We may switch back to tables, but if you want to take a stab, we'd welcome your input.

## Contributing

Fork and submit a pull request. Check out our issues for some stuff that we'd like to see.

If you have a feature request or idea for the project, please add it to the issues list.