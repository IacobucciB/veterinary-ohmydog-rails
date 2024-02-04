import "@hotwired/turbo-rails";
import "controllers";

$(document).ready(function() {
    $('#carouselIndex').carousel({
        interval: 1500 // Cambia el valor en milisegundos
    });
});