//Bài 1: Tạo một đối tượng chứa thông tin về một người bao gồm tên, tuổi, địa chỉ và số điện thoại.
//  Sau đó truy xuất các thuộc tính của đối tượng trên
/*
let person = {
    name: "Nguyen Van A",
    age: 20,
    address: "Hanoi",
    phoneNumber: "0123456789"
};
console.log("Name:", person.name);
console.log("Age:", person.age);
console.log("Address:", person.address);
console.log("Phone Number:", person.phoneNumber);
*/

// Bai 2 :Tạo đối tượng student có các cặp key-value như trong bảng:
// Key	Value
// id	1
// name	Nguyễn Văn A
// gender	nam
// age	20
// mark	8
// Sau đó khởi tạo mảng students chứa nhiều student, rồi thêm một newStudent mới vào.
let students = [
    {id: 1, name: "Nguyen Van A", gender: "nam", age: 20, mark: 8},
    {id: 2, name: "Nguyen Van B", gender: "nu", age: 21, mark: 9},
    {id: 3, name: "Nguyen Van C", gender: "nam", age: 22, mark: 7}
];
let newStudent = {id: 4, name: "Nguyen Van D", gender: "nu", age: 23, mark: 10};
students.push(newStudent);
console.log(students);


//Bài 3: Với dữ liệu từ bài 2 hãy tìm ra học sinh có điểm cao nhất và in ra toàn bộ thông tin của học sinh đó
let highestMarkStudent = students[0];
for (let i = 1; i < students.length; i++) {
    if (students[i].mark > highestMarkStudent.mark) {
        highestMarkStudent = students[i];
    }
}
console.log("Student with highest mark:", highestMarkStudent);
