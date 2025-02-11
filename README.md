# ethereumdashboards-com

This is the source code for <https://ethereumdashboards.com>, a collection of useful dashboards for the Ethereum ecosystem.



## Local Development

1. Clone the repo (or fork the repo to your account)
1. Install dependencies: `bundle install`
1. Create a feature branch off of the `dev` branch
1. Start the local server: `bundle exec jekyll serve`
1. Go to <http://localhost:4400/> to view changes

To build the site use `bundle exec jekyll build`.

Resources:

- [Jekyll Docs](https://jekyllrb.com/docs/)
- [Liquid Syntax](https://shopify.github.io/liquid/basics/introduction/)


## Integrate Data

To use this data, simply query one of the following endpoints:
- `https://ethereumdashboards.com/dashboards.json`
- `https://ethereumdashboards.com/dashboards.yml`

Please do not abuse these endpoints, checking once or twice a day would be sufficient given the update frequency.


## Contributing

To add a new entry, add it to `_data/dashboards.yml` using the template provided.

In `_scripts` there's a python script to convert PNG/JPG/JPEG screenshots to a compressed WEBP:
1. Place screenshots within `assets/img/dashboards/_originals-new`
1. Create virtual environment: `python3 -m venv _scripts/`
1. Start python virtual environment: `. _scripts/bin/activate`
1. Install dependencies: `pip install -r _scripts/requirements.txt`
1. Run the script: `python _scripts/convert_images.py`
1. Close virtual environment: `deactivate`
1. Or run the last 3 steps in one command: `. _scripts/bin/activate && python _scripts/convert_images.py && deactivate`

This will resize the image, convert it to a WEBP, compressed it, place the result in `assets/img/dashboards/` and move the original image to `assets/img/dashboards/_originals`.

If you need to crop (mac includes black bar from webcam with fullscreen screenshots) then you can edit `_scripts/convert_images.py` to set `crop=True` and change the crop parameters if needed.

