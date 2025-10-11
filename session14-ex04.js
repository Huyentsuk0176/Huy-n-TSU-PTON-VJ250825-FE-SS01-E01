/*Tạo một đối tượng original với các thuộc tính sau:

name: "Bob"
age: 30
Yêu cầu:

Sao chép đối tượng này thành một đối tượng mới copy.
Thay đổi giá trị thuộc tính name của copy thành "Charlie".
In cả hai đối tượng ra màn hình và kiểm tra sự khác biệt    
giữa chúng.*/

let original = {
    name: "Bob",
    age: 30
};
let copy = {...original}; // Sử dụng spread operator để sao chép đối tượng
copy.name = "Charlie"; // Thay đổi giá trị thuộc tính name của copy
console.log("Original:", original); // In đối tượng original
console.log("Copy:", copy); // In đối tượng copy
