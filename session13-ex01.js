let arr = []; // Khai báo mảng rỗng
while (arr.length < 10) {
    let randomNumber = Math.floor(Math.random() * 100); // tạo số ngẫu nhiên 0-99
    arr.push(randomNumber); // thêm vào cuối mảng
}
document.getElementById("result").innerText = "Mảng gồm 10 phần tử ngẫu nhiên: " + arr.join(", ");









