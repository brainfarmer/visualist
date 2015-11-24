# Materialize-UI Notes

Visualist uses [Materialize](http://materializecss.com/) to implement material ui elements.

## Adding Materialize-UI to Phoenix project

Phoenix Framework uses Brunch to build static asset pipeline. Brunch build the asset pipeline. Refer to the [Static Assets](http://www.phoenixframework.org/docs/static-assets) section of the Phoenix Framework Guide.

Add Materialize-UI to the project:
  * Download the zip file containing the CSS, JS, and Fonts from [Materialize Getting Started](http://materializecss.com/getting-started.html) page using the Materialize link.
  * Copy the .css files --> /web/static/css
  * Copy the .js file --> /web/static/js
  * Make a new folder `assets` under /web/static
  * Copy the font folder --> /web/static/assets
  * Add the jquery script import as shown in the HTML Setup section

__Note:__ Ignore the explicit script import for materizlize.css since it will be included as part of the static pipeline when it is automatically built with Brunch
