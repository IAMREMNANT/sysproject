// popup.js 파일
(function($) {
    $(document).ready(function() {
        // Magnific Popup 초기화 코드
        $('.popup-youtube').magnificPopup({
            type: 'iframe',
            iframe: {
                patterns: {
                    youtube: {
                        index: 'youtube.com/',
                        id: function(url) {
                            return url.split('v=')[1] || url.split('/shorts/')[1];
                        },
                        src: 'https://www.youtube.com/embed/%id%?autoplay=1'
                    }
                }
            }
        });
    });
})(jQuery);
