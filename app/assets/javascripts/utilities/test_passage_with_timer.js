document.addEventListener('turbolinks:load', function () {
  var timer = document.querySelector('.timer')

  if (timer) {
    var step = 1000;
    var remainingTime = timer.dataset.time;
    var form = document.querySelector('form');

    setInterval(function () {
      if (remainingTime > 0) {
        remainingTime -= 1;
      } else {
        alert('Время вышло');
        form.submit();
      }

      var time = parseInt(remainingTime / 60) + ":" +  remainingTime % 60;
      timer.innerHTML = time

    }, step)
  }

})
