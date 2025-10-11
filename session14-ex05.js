/*Viết một chương trình quản lý danh sách sinh viên với các chức năng cơ bản sau:

1. Thêm sinh viên mới
- Nhập tên, tuổi, mã số sinh viên (ID).
- Thêm sinh viên vào danh sách.
 
2. Hiển thị danh sách sinh viên
- Duyệt qua danh sách và in thông tin của từng sinh viên ra màn hình.
 
3. Xóa sinh viên theo ID
- Nhập ID của sinh viên cần xóa.
- Nếu ID tồn tại, xóa sinh viên khỏi danh sách.
- Nếu ID không tồn tại, thông báo lỗi*/
let students = [];
function addStudent() {
    let name = prompt("Nhập tên sinh viên:");
    let age = prompt("Nhập tuổi sinh viên:");
    let id = prompt("Nhập mã số sinh viên (ID):");
    let student = {
        name: name,
        age: parseInt(age),
        id: id
    };
    students.push(student);
    alert(" Đã thêm sinh viên thành công!");
}
function showStudents() {
    if (students.length === 0) {
        alert("Danh sách trống!");
    } else {
        console.log(" Danh sách sinh viên:");
        students.forEach((student, index) => {
            console.log(`${index + 1}. Tên: ${student.name}, Tuổi: ${student.age}, ID: ${student.id}`);
        });
    }
}

function deleteStudent() {
    let idToDelete = prompt("Nhập ID của sinh viên cần xóa:");
    let index = students.findIndex((student) => student.id === idToDelete);
    if (index !== -1) {
        students.splice(index, 1);
        alert(" Đã xóa sinh viên thành công!");
    } else {
        alert(" Không tìm thấy sinh viên với ID này!");
    }
}
function menu() {
    let choice;
    do {
        choice = prompt(
        "----- MENU QUẢN LÝ SINH VIÊN -----\n" +
        "1. Thêm sinh viên mới\n" +
        "2. Hiển thị danh sách sinh viên\n" +
        "3. Xóa sinh viên theo ID\n" +
        "4. Thoát\n" +
        "Nhập lựa chọn của bạn (1-4):"
        );
        switch (choice) {
        case "1":
            addStudent();
            break;
        case "2":
            showStudents();
            break;
        case "3":
            deleteStudent();
            break;
        case "4":
            alert("Thoát chương trình!")
            break
            default:
                alert("Lựa chọn không hợp lệ! Vui lòng nhập lại.")
                };
    } while (choice !== "4");
}
menu();




