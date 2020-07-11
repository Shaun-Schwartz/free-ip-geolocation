$(document).ready(function() {
  var password = $('#password').val()
  var confirmPassword = $('#confirm-password').val()
  confirmPassword.change(function() {
    if (!minimumLength()) return
    if (passwordsMatch) {
      console.log("YES")
    }
  })
});

function minimumLength(password) {
  return password.length > 6
}

function passwordsMatch(password, confirmPassword) {
  return password === confirmPassword
}
