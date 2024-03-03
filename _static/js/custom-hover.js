document.addEventListener("DOMContentLoaded", function() {
    // Select all links within .sd-card elements
    var links = document.querySelectorAll('.sd-card a');

    // Iterate through each link and add hover event listeners
    links.forEach(function(link) {
        link.addEventListener('mouseover', function() {
            this.style.textDecoration = 'underline';
        });
        link.addEventListener('mouseout', function() {
            this.style.textDecoration = 'none';
        });
    });
});