// Hàm kiểm tra số chẵn
function isEven(number) {
  // Nếu chia hết cho 2 thì là số chẵn
  if (number % 2 === 0) {
    return true;
  } else {
    return false;
  }
}

// Nhập 1 số nguyên bất kỳ từ bàn phím
let num = +prompt("Nhập vào một số nguyên bất kỳ:");

// Gọi hàm kiểm tra
let result = isEven(num);

// Hiển thị kết quả
if (result) {
  alert(num + " là số chẵn.");
} else {
  alert(num + " là số lẻ.");
}
