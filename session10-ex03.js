
// rectangle.js

// Khai báo biến chiều rộng và chiều cao
let width = 10;   // độ rộng (có thể thay đổi)
let height = 5;   // chiều cao (có thể thay đổi)

// Tính diện tích
let area = width * height;

// In kết quả ra màn hình console
console.log("Chiều rộng: " + width);
console.log("Chiều cao: " + height);
console.log("Diện tích hình chữ nhật là: " + area);

// Hiển thị ra trang web
document.getElementById("output").innerText =
  "Chiều rộng: " + width + 
  ", Chiều cao: " + height + 
  ", Diện tích: " + area;
