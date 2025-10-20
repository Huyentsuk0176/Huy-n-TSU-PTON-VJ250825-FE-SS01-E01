
const form = document.getElementById("registerForm");

  form.addEventListener("submit", function(event) {
    event.preventDefault();

    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value.trim();
    const confirmPassword = document.getElementById("confirmPassword").value.trim();

    // Kiểm tra dữ liệu rỗng
    if (!email || !password || !confirmPassword) {
      alert("Vui lòng nhập đầy đủ thông tin!");
      return;
    }

    // Kiểm tra trùng mật khẩu
    if (password !== confirmPassword) {
      alert("Mật khẩu xác nhận không khớp!");
      return;
    }

    // Lấy danh sách user đã lưu
    let users = JSON.parse(localStorage.getItem("users")) || [];

    // Kiểm tra email đã tồn tại
    const existingUser = users.find(user => user.email === email);
    if (existingUser) {
      alert("Email đã được đăng ký!");
      return;
    }

    // Lưu tài khoản mới
    users.push({ email, password });
    localStorage.setItem("users", JSON.stringify(users));

    alert("Đăng ký thành công!");
    form.reset();
  });