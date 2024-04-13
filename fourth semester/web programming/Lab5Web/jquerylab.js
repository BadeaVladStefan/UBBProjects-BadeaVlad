$(document).ready(function() {
    var lastClickTime = new Date().getTime();
    $('.desktop1').addClass('visible');
    $('.screen').click(function() {

        var nextDesktop = $(this).next('.screen');
        if (!nextDesktop.length) {
            nextDesktop = $('.screen').first();
        }

        var currentTime = new Date().getTime();
        var timeSinceLastClick = currentTime - lastClickTime;

        if (timeSinceLastClick < 500) {
            return;
        }
        lastClickTime = currentTime;

        $(this).animate({ bottom: '100vh' }, 500, function() {
            $(this).removeClass('visible');
        });

        nextDesktop.css('bottom', '-100vh').addClass('visible').animate({ bottom: '0' }, 500);

    });
});