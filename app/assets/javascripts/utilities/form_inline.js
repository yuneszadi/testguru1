document.addEventListener('turbolinks:load', function () {
  $('.form-inline-link').on('click', formInlineLinkHandler)

  var errors = document.querySelector('.resource-errors')
  if (errors) {
    var resourceId = errors.dataset.resourceId;
    formInlineHandler(resourceId);
  }
})

function formInlineLinkHandler(event) {
  event.preventDefault();
  var testId = this.dataset.testId;
  formInlineHandler(testId);
}

function formInlineHandler(testId, resourceTitle='') {
  var link = document.querySelector('.form-inline-link[data-test-id="' +testId+ '"]');
  var formInline = document.querySelector('.form-inline[data-test-id="' +testId+ '"]');
  var testTitle = document.querySelector('.test-title[data-test-id="' +testId+ '"]');
  if (formInline.classList.contains('hide')) {
    testTitle.classList.add('hide');
    formInline.classList.remove('hide');
    link.textContent = "Cancel";
  } else {
    formInline.classList.add('hide');
    testTitle.classList.remove('hide');
    link.textContent = "Edit";
  }
}
