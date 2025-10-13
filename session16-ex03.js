function sum(a, b) {
  return a + b;
}

// Nhập dữ liệu từ người dùng
let num1 = +prompt("Nhập số thứ nhất:");
let num2 = +prompt("Nhập số thứ hai:");

// Gọi hàm sum
let result = sum(num1, num2);

// Hiển thị kết quả
alert("Tổng của hai số là: " + result);
