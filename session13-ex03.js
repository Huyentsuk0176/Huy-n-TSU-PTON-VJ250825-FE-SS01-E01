function daoNguocMang() {
    let input = prompt("Nhập dãy số, cách nhau bằng dấu phẩy (ví dụ: 1,2,3,4,5)");
    let arr = input.split(",");
    arr.reverse();
    document.getElementById("result").innerText =
        "Mảng sau khi đảo ngược: " + arr.join(", ");
}











