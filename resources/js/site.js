import Glide from '@glidejs/glide';

window.onload = () => {
    let glide = new Glide ( '.glide', {
        type: "carousel",
        focusAt: "center",
        perView: 1
    } ).mount ();

    document.querySelector ( ".glide-page-number" ).appendChild ( document.createTextNode ( "1/5" ) );
    
    glide.on ( 'run', glideChangeCallback );

    initFAQs ();
}

function glideChangeCallback ( move ) {
    let slide_number;

    if ( move.steps === "0" ) {
        slide_number = 0;
    }
    else {
        slide_number = move.steps;
    }

    updateGlidePageNumber ( slide_number );
}

function updateGlidePageNumber ( slide_number ) {
    slide_number += 1;

    const page_number_div = document.querySelector ( ".glide-page-number" );

    while ( page_number_div.firstChild ) {
        page_number_div.removeChild ( page_number_div.lastChild );
    }

    page_number_div.appendChild ( document.createTextNode ( `${slide_number}/5` ) );
}

function initFAQs () {
    const faqs = document.querySelectorAll ( '.faqs .collapse-icon-container' );

    faqs.forEach ( element => {
        element.addEventListener ( 'click', () => {
            let answer_element = element.parentElement.parentElement.getElementsByClassName ( "faqs-answer" ) [ 0 ];

            if ( answer_element == null ) {
                console.log ( "element is null" );
                return;
            }

            if ( answer_element.style.maxHeight == 0 ) {
                console.log ( "setting the max height to the scroll height which is " + answer_element.scrollHeight + "px" );
                answer_element.style.maxHeight = answer_element.scrollHeight + "px";
            }
            else {
                console.log ( "setting the max height to 0" );
                answer_element.style.maxHeight = null;
            }
        } );
    } );
}