document.addEventListener('DOMContentLoaded', function(){
  $(document).on('turbolinks:load', function() {
    
    if ($('preview-container')) {
      const $previewContainer = $('#preview-container');
  
      const createImageHTML  = (imageURL) => {
  
        const $imageElement = $('<div>').attr('id', 'setting-image');
        const $blobElement = $('<img>').attr('src', imageURL);
  
        if ((location.pathname).match('article')) {
          $blobElement.attr('id', 'preview-jacket');
        } else {
          $blobElement.attr('id', 'preview-icon');
        }

        $imageElement.append($blobElement);
        $previewContainer.append($imageElement);
  
        $blobElement.onload = function() {
          window.URL.revokeObjectURL(imageURL);
        }
      };
  
  
      $('#form').on('change', function(e) {
        const file = e.target.files[0];
        const imageURL = window.URL.createObjectURL(file);
  
        if ($('#setting-image')) {
          $('#setting-image').remove();
        }
  
        createImageHTML(imageURL);
  
      })
    };
    
  });
});