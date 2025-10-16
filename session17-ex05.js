function login() {
      
      const username = document.getElementById("username").value;
      const password = document.getElementById("password").value;

      const correctUsername = "huanrose@gmail.com";
      const correctPassword = "123456";

    
      if (username === correctUsername && password === correctPassword) {
        alert("Đăng nhập thành công!");
      } else {
        alert("Đăng nhập thất bại!");
      }
    }