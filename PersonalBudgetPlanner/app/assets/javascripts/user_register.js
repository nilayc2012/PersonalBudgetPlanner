
function validate()
  { 
  var passw = document.getElementById('pd').value;
  var cpassw = document.getElementById('cpd').value;
    if((passw.length <= 4 && passw.length!=0) ||(cpassw.length <= 4 && cpassw.length!=0)){
      alert('Error: Password must contain at least five characters!');
      return false;
        }
		  if(passw!=cpassw && cpassw.length!=0){
        alert('Error: Password do not match Please enter correct confirm password');
      return false;
  } 
  return true;
  }