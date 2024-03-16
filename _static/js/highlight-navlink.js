// Highlight Navbar for Corresponding Page User is Viewing
document.addEventListener("DOMContentLoaded", function(){
    var links = document.querySelectorAll('.nav.bd-sidenav a');
    var currentUrl = window.location.pathname;
    
    links.forEach(function(link){
      if(link.getAttribute('href') === currentUrl) {
        link.parentElement.classList.add('active');
        
        // If it's a child item, also expand and highlight the parent
        if (link.parentElement.classList.contains('toctree-l2')) {
          link.parentElement.parentElement.parentElement.classList.add('active');
          var parentCheckbox = link.closest('.toctree-l1.has-children').querySelector('input[type="checkbox"]');
          if (parentCheckbox) {
            parentCheckbox.checked = true;
          }
        }
      }
    });
  });
  