// Bài 1: Viết chương trình nhập vào 2 số a và b. Kiểm tra xem a có chia hết cho b hay không?
// Nếu chia hết thì in ra "a chia hết cho b", ngược lại in ra "a không chia hết cho b".
let a = parseInt(prompt("Nhập số a:"));
let b = parseInt(prompt("Nhập số b:"));

if (b !== 0) {
    if (a % b === 0) {
        console.log(a + " chia hết cho " + b);
    } else {
        console.log(a + " không chia hết cho " + b);
    }
} else {
    console.log("Không thể chia cho 0");
}

//Đề bài 2:
//Nhập tuổi và in ra kết quả:
//Nếu tuổi < 0: không hợp lệ
//Nếu tuổi đủ điều kiện đi học lớp 10 (>= 15): in thông báo hợp lệ.

let age = parseInt(prompt("Nhập tuổi:"));

if (age < 0) {
    console.log("Tuổi không hợp lệ!");
} else if (age >= 15) {
    console.log("Đủ điều kiện vào lớp 10");
} else {
    console.log("Chưa đủ điều kiện vào lớp 10");
}

//Đề bài 3:
// Nhập một số nguyên bất kỳ, in ra kết quả cho biết số đó lớn hơn 0, nhỏ hơn 0 hay bằng 0.
let n = parseInt(prompt("Nhập một số nguyên:"));

if (n > 0) {
    console.log("Số " + n + " lớn hơn 0");
} else if (n < 0) {
    console.log("Số " + n + " nhỏ hơn 0");
} else {
    console.log("Số bằng 0");
}

//Bai 4:Nhập 3 số nguyên và tìm giá trị lớn nhất.
let x = parseInt(prompt("Nhập số thứ nhất:"));
let y = parseInt(prompt("Nhập số thứ hai:"));
let z = parseInt(prompt("Nhập số thứ ba:"));    
let max = x;
if (y > max) {
    max = y;
}
if (z > max) {
    max = z;
}
console.log("Số lớn nhất là: " + max);

//Bai 5 Xếp hạng học lực của học sinh dựa trên điểm kiểm tra, điểm thi giữa kỳ và điểm thi cuối kỳ.
//👉 Thang đánh giá: Xuất sắc, Giỏi, Khá, Trung Bình, Yếu.
let test = parseFloat(prompt("Nhập điểm kiểm tra:"));
let mid = parseFloat(prompt("Nhập điểm giữa kỳ:"));
let final = parseFloat(prompt("Nhập điểm cuối kỳ:"));

let avg = (test + mid + final) / 3;

if (avg >= 9) {
    console.log("Xuất sắc");
} else if (avg >= 8) {
    console.log("Giỏi");
} else if (avg >= 6.5) {
    console.log("Khá");
} else if (avg >= 5) {
    console.log("Trung bình");
} else {
    console.log("Yếu");
}


















