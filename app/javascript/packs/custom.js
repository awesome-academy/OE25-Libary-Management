document.querySelector("#module_topcategories > h2")

$(document).ready(function(){
  $(document).on('change', '.upload-img', function(){
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $('#img_prev')
        .attr('src', e.target.result)
        .width(290)
        .height(360);
      };

      reader.readAsDataURL(input.files[0]);
    }
  })

  $(document).on('change', '.upload-img', function(){
    readURL(this);
  });

  $(document).on('click', 'tr[data-link]', function(){
    window.location = $(this).data("link")
  });

  setTimeout(function(){
    $('p.alert').remove();
  }, 3000);

  $(document).on('click', 'tr[data-link]', function(){
    window.location = $(this).data('link')
  });
});

