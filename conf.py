import os
from docutils import nodes, utils
from docutils.parsers.rst import roles

os.chdir(os.path.dirname(os.path.abspath(__file__)))

# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
project = 'Dimecoin Docs'
copyright = '2024, Dimecoin Developers'
author = 'Dhop14'

version = u'latest'
release = u'latest'

# -- General configuration ---------------------------------------------------
extensions = [
  'hoverxref.extension',
  'myst_parser',
  'sphinx.ext.autodoc',
  'sphinx_copybutton',
  'sphinx_design',
  'sphinx_search.extension',
  'sphinx.ext.intersphinx',
]

templates_path = ['_templates']
exclude_patterns = ['_build', '_dips', 'Thumbs.db', '.DS_Store', 'README.md', '.devcontainer', 'scripts', 'img/dev/gifs/README.md']

master_doc = 'index'

hoverxref_role_types = {
    'hoverxref': 'tooltip',
}

# -- Myst parser configuration -----------------------------------------------
myst_heading_anchors = 5
myst_enable_extensions = ["colon_fence"]

# -- intersphinx configuration -----------------------------------------------
intersphinx_mapping = {
}

intersphinx_disabled_reftypes = ["*"]

# -- Options for HTML output -------------------------------------------------
html_theme = "pydata_sphinx_theme"
html_static_path = ['_static']
html_logo = 'img/dime_logo.png'
html_css_files = [
    'css/footer.css',
    'css/pydata-overrides.css',
]

html_sidebars = {
    "index": ["sidebar-main.html"],
    "docs/index": ["sidebar-nav2.html"],
    "**": ["sidebar-sub-nav.html"],
  
}

html_theme_options = {
    "external_links": [
        {"name": "Electrum-Dime Docs", "url": "https://electrum-docs.dimecoinnetwork.com"},
        {"name": "ElectrumXDime Docs", "url": "https://electrumx-docs.dimecoinnetwork.com/"},        
        {"name": "Web Home", "url": "https://www.dimecoinnetwork.com"},
    ],
    "use_edit_page_button": True,
    "github_url": "https://github.com/dime-coin/core-docs",
    "show_toc_level": 2,
    "show_nav_level": 1,
    "favicons": [
      {
         "rel": "icon",
         "sizes": "16x16",
         "href": "img/favicon-16x16.png",
      },
      {
         "rel": "icon",
         "sizes": "32x32",
         "href": "img/favicon-32x32.png",
      },
      {
         "rel": "icon",
         "sizes": "96x96",
         "href": "img/favicon-96x96.png",
      },
      {
         "rel": "icon",
         "sizes": "144x144",
         "href": "img/favicon-144x144.png",
      },
   ],
   "footer_start": ["copyright"],
   "footer_center": ["sphinx-version"],
   "footer_end": ["theme-version"],
}

html_context = {
    "github_user": "dime-coin",
    "github_repo": "core-docs",
    "github_version": "main",
    "doc_path": "",
}

def external_link_role(name, rawtext, text, lineno, inliner, options={}, content=[]):
    """Create an external link that opens in a new tab."""
    try:
        base_url, link_text = text.split(None, 1)
    except ValueError:
        base_url = text
        link_text = text
    node = nodes.reference(rawtext, utils.unescape(link_text), refuri=base_url, **options)
    node['target'] = '_blank'
    return [node], []

def setup(app):
    app.add_js_file('js/pydata-search-close.js')
    roles.register_local_role('extlink', external_link_role)