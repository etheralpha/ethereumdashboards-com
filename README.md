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

In `_scripts` there's a python script to convert `.png` screenshots within `assets/img/dashboards/_originals` to a compressed `.webp` and save the result in `assets/img/dashboards`. You can use `. _scripts/bin/activate` from root to activate the virtual environment. Then use `python _scripts/convert_images.py` to run the script.

