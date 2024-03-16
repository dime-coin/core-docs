// Script to allow use of readthedocs-sphinx-search extension with the pydata
// theme
//
// Based in part on:
// https://github.com/pydata/pydata-sphinx-theme/blob/v0.13.3/src/pydata_sphinx_theme/assets/scripts/pydata-sphinx-theme.js#L167-L272

/*******************************************************************************
 * Search
 */
/** Find any search forms on the page and return their input element */
var findSearchInput = () => {
  let forms = document.querySelectorAll("form.bd-search");
  if (!forms.length) {
    // no search form found
    return;
  } else {
    var form;
    if (forms.length == 1) {
      // there is exactly one search form (persistent or hidden)
      form = forms[0];
    } else {
      // must be at least one persistent form, use the first persistent one
      form = document.querySelector(
        "div:not(.search-button__search-container) > form.bd-search"
      );
    }
    return form.querySelector("input");
  }
};

/** Function to hide the search field */
var hideSearchField = () => {
 
  let input = findSearchInput();
  let searchPopupWrapper = document.querySelector(".search-button__wrapper");
  let hiddenInput = searchPopupWrapper.querySelector("input");
  
  if (input === hiddenInput) {
    searchPopupWrapper.classList.remove("show");
  }
  
  if (document.activeElement === input) {
    input.blur();
  }
};

/** Add an event listener for hideSearchField() for Escape*/
var addEventListenerForSearchKeyboard = () => {
  window.addEventListener(
    "keydown",
    (event) => {
      // Allow Escape key to hide the search field
      if (event.code == "Escape") {
        hideSearchField();
      }
    },
    true
  );
};

/** Activate callbacks for search button popup */
var setupSearchButtons = () => {
  addEventListenerForSearchKeyboard();
};

// Custom code to manage closing the RtD search dialog properly
$(document).ready(function(){
  $(".search__cross").click(function(){
    hideSearchField();
  });
  $(".search__outer__wrapper.search__backdrop").click(function(){
    hideSearchField();
  });
  $(".search-button__overlay").click(function(){
    // Shouldn't be necessary since it's currently hidden by CSS, but just in
    // case
    console.log("Close by search-button__overlay");
    hideSearchField();
  });
});

$(setupSearchButtons);

// highlight topic

document.addEventListener("DOMContentLoaded", function() {
  // Find all sidebar links
  var links = document.querySelectorAll('.bd-sidenav .toctree-l1 > a');

  // Function to clear all active states
  function clearActive() {
    links.forEach(function(link) {
      link.parentElement.classList.remove('active'); // Assuming 'active' class indicates the current page
    });
  }

  // Function to set a link as active based on the current URL
  function setActive() {
    clearActive();
    links.forEach(function(link) {
      if(link.href === window.location.href) {
        link.parentElement.classList.add('active');
      }
    });
  }

  // Set the correct active link when the page loads
  setActive();

  // Optional: If you want to ensure the active state updates for SPA or when using anchors, you might need to listen to clicks or hash changes as well
  window.addEventListener('hashchange', setActive, false);
  links.forEach(function(link) {
    link.addEventListener('click', function() {
      // Timeout to allow page update
      setTimeout(setActive, 50);
    });
  });
});
