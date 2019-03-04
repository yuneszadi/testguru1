$(document).ready(function() {
  $('#timer-field').hide();
  $('#checkbox').on('click', function () {
    if ($('.checkbox-input:checked')) {
      $('#timer-field').show();
    } else {
      $('#timer-field').hide();
    }
  })
})
