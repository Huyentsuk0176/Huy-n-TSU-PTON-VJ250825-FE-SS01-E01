let choice = parseInt(prompt(
    "=== MENU BÀI TẬP MẢNG ===\n" +
    "1. Đếm số >= 10\n" +
    "2. Tìm giá trị lớn nhất & vị trí\n" +
    "3. Giá trị lớn nhất & trung bình\n" +
    "4. Đảo ngược mảng\n" +
    "5. Đếm số âm trong chuỗi\n" +
    "6. Kiểm tra số có trong mảng không\n" +
    "7. Sắp xếp mảng giảm dần\n" +
    "8. Nối 2 mảng a & b\n" +
    "=========================\n" +
    "Nhập số bài muốn chạy:"
));
switch (choice) {
    case 1:
        // Bài 1: Đếm số >= 10
        let arr1 = [];
        for (let i = 0; i < 10; i++) {
            arr1.push(parseInt(prompt("Nhập số thứ " + (i + 1) + ":")));
        }
        let count = 0;
        for (let num of arr1) {
            if (num >= 10) count++;
        }
        alert("Có " + count + " số lớn hơn hoặc bằng 10");
        break;
    case 2:
        // Bài 2: Tìm giá trị lớn nhất & vị trí
        let arr2 = [];
        for (let i = 0; i < 10; i++) {
            arr2.push(parseInt(prompt("Nhập số thứ " + (i + 1) + ":")));
        }
        let max2 = arr2[0];
        let pos2 = 0;
        for (let i = 1; i < arr2.length; i++) {
            if (arr2[i] > max2) {
                max2 = arr2[i];
                pos2 = i;
            }
        }
        alert("Giá trị lớn nhất: " + max2 + " tại vị trí: " + pos2);
        break;
      case 3:
        // Bài 3: Giá trị lớn nhất và trung bình
        let arr3 = [];
        for (let i = 0; i < 10; i++) {
          arr3.push(parseInt(prompt("Nhập số thứ " + (i + 1) + ":")));
        }
        let max3 = arr3[0];
        let sum3 = 0;
        for (let num of arr3) {
          if (num > max3) max3 = num;
          sum3 += num;
        }
        let avg3 = sum3 / arr3.length;
        alert("Giá trị lớn nhất: " + max3 + "\nGiá trị trung bình: " + avg3);
        break;

      case 4:
        // Bài 4: Đảo ngược mảng
        let arr4 = [];
        for (let i = 0; i < 10; i++) {
          arr4.push(parseInt(prompt("Nhập số thứ " + (i + 1) + ":")));
        }
        arr4.reverse();
        alert("Mảng sau khi đảo ngược: " + arr4);
        break;

      case 5:
        // Bài 5: Đếm số âm trong chuỗi
        let str5 = prompt("Nhập chuỗi số cách nhau bởi dấu cách:");
        let arr5 = str5.split(" ").map(Number);
        let count5 = 0;
        for (let num of arr5) {
          if (num < 0) count5++;
        }
        alert("Có " + count5 + " số nguyên âm trong chuỗi.");
        break;

      case 6:
        // Bài 6: Kiểm tra số có trong mảng không
        let arr6 = [];
        for (let i = 0; i < 10; i++) {
          arr6.push(parseInt(prompt("Nhập số thứ " + (i + 1) + ":")));
        }
        let x6 = parseInt(prompt("Nhập số cần kiểm tra:"));
        if (arr6.includes(x6)) {
          alert("Number " + x6 + " is in the array");
        } else {
          alert("Number " + x6 + " is not in the array");
        }
        break;

      case 7:
        // Bài 7: Sắp xếp giảm dần
        let arr7 = [];
        for (let i = 0; i < 10; i++) {
          arr7.push(parseInt(prompt("Nhập số thứ " + (i + 1) + ":")));
        }
        arr7.sort((a, b) => b - a);
        alert("Mảng sau khi sắp xếp giảm dần: " + arr7);
        break;

      case 8:
        // Bài 8: Nối hai mảng
        let a = [], b = [];
        for (let i = 0; i < 10; i++) {
          a.push(parseInt(prompt("Nhập phần tử mảng a thứ " + (i + 1) + ":")));
        }
        for (let i = 0; i < 10; i++) {
          b.push(parseInt(prompt("Nhập phần tử mảng b thứ " + (i + 1) + ":")));
        }
        let c = a.concat(b);
        alert("Mảng c sau khi nối: " + c);
        break;

      default:
        alert("Lựa chọn không hợp lệ!");
    }