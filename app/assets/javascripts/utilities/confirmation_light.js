document.addEventListener('turbolinks:load', function () {
  var confirm = document.querySelector('.confirm-password')
  if (confirm) { confirm.addEventListener('focus', compareValue(confirm)) }
})

function compareValue(confirm) {
  confirm.addEventListener('keyup', function () {
    var password = document.querySelector('.password')
    var passwordConfirm = document.querySelector('.confirm-password')
    var passwordInput = [password, passwordConfirm]
    for (var i = 0; i < passwordInput.length; i++) {
      if (passwordConfirm.value == '') {
        passwordInput[i].classList.remove('border-green')
        passwordInput[i].classList.remove('border-red')
      } else if (password.value == passwordConfirm.value) {
        passwordInput[i].classList.add('border-green')
        passwordInput[i].classList.remove('border-red')
      } else {
        passwordInput[i].classList.remove('border-green')
        passwordInput[i].classList.add('border-red')
      }
    }
  })
}
