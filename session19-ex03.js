
const users = [
  { email: "Phthihuyenta03@gmail.com", password: "Huyen1991@" },
  { email: "user1@gmail.com", password: "123456" },
  { email: "user2@gmail.com", password: "abcdef" }
];

document.addEventListener("DOMContentLoaded", () => {
  const emailInput = document.getElementById("email");
  const passwordInput = document.getElementById("password");
  const loginBtn = document.getElementById("loginBtn");
  const toggleEye = document.getElementById("toggleEye");

  
  toggleEye.addEventListener("click", () => {
    const type = passwordInput.type === "password" ? "text" : "password";
    passwordInput.type = type;
  });


  loginBtn.addEventListener("click", () => {
    
    document.getElementById("emailError").textContent = "";
    document.getElementById("passwordError").textContent = "";

    const email = emailInput.value.trim();
    const password = passwordInput.value.trim();

  
    if (email === "") {
      document.getElementById("emailError").textContent = "Email không được để trống";
      return;
    }

    if (password === "") {
      document.getElementById("passwordError").textContent = "Vui lòng nhập mật khẩu";
      return;
    }

    
    const emailPattern = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
    if (!emailPattern.test(email)) {
      document.getElementById("emailError").textContent = "Định dạng email không hợp lệ";
      return;
    }

  
    const foundUser = users.find(
      (user) => user.email === email && user.password === password
    );

    if (foundUser) {
      alert("Đăng nhập thành công!");
      window.location.href = "home.html"; 
    } else {
      document.getElementById("passwordError").textContent = "Email hoặc mật khẩu không đúng";
    }
  });
});
