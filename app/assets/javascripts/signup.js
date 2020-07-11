$(document).ready(function() {
  var password = $('#password').val()
  var confirmPassword = $('#confirm-password').val()
  $('#confirm-password').change(function() {
    if (password.length <= 6) return
    if (password === confirmPassword)
      console.log("YES")
  })
});
