//Hãy thực hiện cho người dùng nhập vào dãy số bất kỳ.
//  Sử dụng split() để chuyển đổi kiểu dữ liệu từ string sang kiểu array.
//  Tiến hành duyệt các phần tử và tìm ra phần tử có giá trị lớn nhất trong mảng và
//  thực hiện in ra màn hình bằng alert()



let input = prompt("Nhập vào dãy số, cách nhau bởi dấu phẩy:");
let numbers = input.split(",").map(Number);
let maxNumber = Math.max(...numbers);
alert("Phần tử có giá trị lớn nhất trong mảng là: " + maxNumber);





