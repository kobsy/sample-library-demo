function lightboxShow() {
	$('#lightbox_content').prepend('<a href="javascript:lightboxHide();" class="LightboxClose">CLOSE</a>');
	$('#lightbox_bg').css('display','block').animate({'opacity': '0.7'}, 'fast');
	$('#lightbox_content').css('display', 'block').animate({'opacity': '1.0'}, 'fast');
	$('#lightbox_bg').click(function() { lightboxHide(); });
}

function lightboxHide() {
	$('#lightbox_bg').animate({'opacity': '0'}, 'fast', function() { $(this).css('display', 'none'); });
	$('#lightbox_content').animate({'opacity': '0'}, 'fast', function() { $(this).css('display', 'none'); });
}