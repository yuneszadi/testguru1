document.addEventListener('turbolinks:load', function () {
  var progressBar = document.querySelector('.progress-bar');
  if (progressBar) {
    var currentQuestion = progressBar.dataset.currentQuestion - 1;
    var allQuestion = progressBar.dataset.allQuestion;
    var width = (currentQuestion / allQuestion * 100) + "%";
    progressBar.style.width = width;
    console.log(progressBar);
  }
})
