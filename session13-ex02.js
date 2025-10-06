let arr = [2, 4, 6, 8, 45, 64, 85, 90, 95, 99];

    // 2️⃣ Hàm kiểm tra
    function kiemTraSo() {
      // Nhập số từ người dùng
      let nhap = prompt("Nhập vào một số bất kỳ:");

      // Chuyển chuỗi nhập vào thành số
      let soNhap = Number(nhap);

      // 3️⃣ Kiểm tra xem số đó có trong mảng không
      if (arr.includes(soNhap)) {
        alert(" Bingo! Số bạn nhập có trong mảng!");
      } else {
        alert("Chúc bạn may mắn lần sau!");
      }
    }