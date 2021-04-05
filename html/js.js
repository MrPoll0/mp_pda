var cursor = $('#cursor');


var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

var cursor = document.getElementById("cursor");
var cursorX = documentWidth / 2;
var cursorY = documentHeight / 2;

function Click(x, y) {
    var element = $(document.elementFromPoint(x, y));
    element.focus().click();
}

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "on") {
             document.body.style.display = event.data.enable ? "block" : "none";
            $("#cursor").css("display", "block");
        } else if (event.data.type == "click") {
            // Avoid clicking the cursor itself, click 1px to the top/left;
            Click(cursorX - 1, cursorY - 1);
        }
    });

    $(document).mousemove(function(event) {
        cursorX = event.pageX;
        cursorY = event.pageY;
    });

    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('http://mp_pda/escape', JSON.stringify({}));
            document.body.style.display = event.data.enable ? "block" : "none";
            $("#cursor").css("display", "block");
        }
    };
});
