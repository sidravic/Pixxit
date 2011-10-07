function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");

    $(link).parent().parent().find('.end-of-the-line').before(content.replace(regexp, new_id));
}

(function($, window, document, PB){
    PB.DynamicOperations = {
        hideToggle: function(selector, elements){
            $(selector).click(function(e){
                e.preventDefault();
                if($(this).attr('class').indexOf('hide-text') != -1){
                    $(this).parent().parent().find(elements).hide();
                    $(this).removeClass('hide-text').addClass('show-text').html('Show text');
                }
                else if($(this).attr('class').indexOf('show-text') != -1)
                {
                    $(this).parent().parent().find(elements).show();
                    $(this).removeClass('show-text').addClass('hide-text').html('Hide text');
                }


            });
        }
    };

    PB.PhotoNavigator = {
        navigate : function(){
            $('.photo-nav').click(function(e){
                e.preventDefault();
                var klasses = $(this).attr('class');
                var post_id = klasses.split(" ")[1].split('-')[1];
                var image_index = klasses.split(" ")[2].split('-')[1];

                $('img.post-' + post_id).addClass('hidden');
                $($('img.post-' + post_id)[image_index]).removeClass('hidden');
                $('.photo-nav').css('font-weight','normal');
                $(this).css("font-weight",'bold');

            });
        }

    }

    $(document).ready(function(){
        if(('.post-display').length > 0){
            PB.DynamicOperations.hideToggle('.hide-text', '.hideable');
            PB.DynamicOperations.hideToggle('.show-text', '.hideable');
        }


        if(('.photo-nav').length > 0){
            PB.PhotoNavigator.navigate();
        }
    })

})(jQuery, this, this.doccument, {});