/*

JavaScript for Library Resources
Uses jQuery for Ajax

*/
$(document).ready( function() {
	$('a[data-remote]').on('ajax:success', function(event, xhr, status, error) {
		//$('#lightbox_content').html(xhr.responseText);
		//lightboxShow();
	});
});