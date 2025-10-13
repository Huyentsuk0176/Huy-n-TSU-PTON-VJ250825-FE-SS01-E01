let choice = parseInt(prompt(
      "=== MENU BÀI TẬP CHUỖI ===\n" +
      "1. Đảo ngược mảng ký tự\n" +
      "2. Đếm số ký tự là số trong mảng\n" +
      "3. Đếm số ký tự trong chuỗi\n" +
      "4. Kiểm tra hai chuỗi có giống nhau không\n" +
      "5. Thay '-' bằng '_' trong mảng ký tự\n" +
      "===========================\n" +
      "Nhập số bài bạn muốn chạy:"
    ));

    switch (choice) {
      case 1:
        // Bài 1: Đảo ngược mảng ký tự
        let arr1 = ['c', 's', 'c', '2', '6', '1'];
        let reversed = arr1.reverse();
        let result1 = reversed.join("");
        alert("Kết quả sau khi đảo ngược: " + result1);
        break;

      case 2:
        // Bài 2: Đếm ký tự là số trong mảng
        let arr2 = ['a', '1', 'b', '3', '9', 'x', '2'];
        let count2 = 0;
        for (let i = 0; i < arr2.length; i++) {
          if (!isNaN(arr2[i]) && arr2[i] !== " ") {
            count2++;
          }
        }
        alert("Có " + count2 + " ký tự là số trong mảng.");
        break;

      case 3:
        // Bài 3: Đếm số ký tự trong chuỗi
        let str3 = prompt("Nhập vào một chuỗi bất kỳ:");
        let count3 = str3.length;
        alert("Chuỗi có " + count3 + " ký tự.");
        break;

      case 4:
        // Bài 4: So sánh hai chuỗi
        let str4a = prompt("Nhập chuỗi thứ nhất:");
        let str4b = prompt("Nhập chuỗi thứ hai:");
        if (str4a === str4b) {
          alert("Hai chuỗi giống nhau");
        } else {
          alert("Hai chuỗi khác nhau");
        }
        break;

      case 5:
        // Bài 5: Thay '-' bằng '_' trong mảng ký tự
        let arr5 = ['a', '-', 'b', '-', 'c', '_', 'd'];
        for (let i = 0; i < arr5.length; i++) {
          if (arr5[i] === '-') arr5[i] = '_';
        }
        alert("Mảng sau khi thay thế: " + arr5.join(""));
        break;

      default:
        alert("Lựa chọn không hợp lệ!");
    }