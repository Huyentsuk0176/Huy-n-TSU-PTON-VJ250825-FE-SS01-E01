
// 1️⃣ Khai báo các mảng
const arr1 = [3, 5, 1, 8, -3, 7, 8];
const arr2 = [7, 12, 6, 9, 20, 56, 89];
const arr3 = [];
const arr4 = [0, 0, 0, 0, 0];

// 2️⃣ Xây dựng hàm tìm giá trị nhỏ nhất
function findMin(arr) {
  // Nếu mảng rỗng
  if (arr.length === 0) {
    return "Mảng rỗng";
  }

  // Giả sử phần tử đầu tiên là nhỏ nhất
  let min = arr[0];

  // Duyệt mảng để tìm giá trị nhỏ hơn
  for (let i = 1; i < arr.length; i++) {
    if (arr[i] < min) {
      min = arr[i];
    }
  }

  // Trả về giá trị nhỏ nhất
  return min;
}

// 3️⃣ Kiểm tra với các mảng
console.log(findMin(arr1)); // -3
console.log(findMin(arr2)); // 6
console.log(findMin(arr3)); // "Mảng rỗng"
console.log(findMin(arr4)); // 0
