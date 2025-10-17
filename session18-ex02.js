/*let products = [
  { id: 1, name: "Milk", count: 100 },
  { id: 2, name: "Orange", count: 100 },
  { id: 3, name: "Butter", count: 100 },
];*/
//Thêm đối tượng sản phẩm mới vào mảng products
//Xóa đối tượng sản phẩm có id = 2
//Cập nhật đối tượng có id = 3, cho count = 0
// Kiểm tra xem sản phẩm Butter có trong mảng không.

/*let products = [
    { id: 1, name: "Milk", count: 100 },
    { id: 2, name: "Orange", count: 100 },
    { id: 3, name: "Butter", count: 100 },
    ];
// Thêm đối tượng sản phẩm mới vào mảng products
products.push({ id: 4, name: "Bread", count: 50 });
console.log("After adding new product:", products);
// Xóa đối tượng sản phẩm có id = 2
products = products.filter(product => product.id !== 2);
console.log("After deleting product with id = 2:", products);
// Cập nhật đối tượng có id = 3, cho count = 0
const productToUpdate = products.find(product => product.id === 3);
if (productToUpdate) {
    productToUpdate.count = 0;
}
console.log("After updating product with id = 3:", products);
// Kiểm tra xem sản phẩm Butter có trong mảng không.
const hasButter = products.some(product => product.name === "Butter");
console.log("Is Butter in the products array?", hasButter);


// Bài 2 -CRUDE:
// Create/Read/Update/Delete/Exit
/*let courses = [
  { id: 1, name: "HTML", complete: false },
  { id: 2, name: "CSS", complete: false },
  { id: 3, name: "Basic of JavaScript", complete: false },
  { id: 4, name: "Node Package Manager (npm)", complete: false },
  { id: 5, name: "Git", complete: false },*/

// Viết chương trình cho phép người dùng thao tác với mảng courses thông qua các chức năng CRUD
let courses = [
    { id: 1, name: "HTML", complete: false },
    { id: 2, name: "CSS", complete: false },
    { id: 3, name: "Basic of JavaScript", complete: false },
    { id: 4, name: "Node Package Manager (npm)", complete: false },
    { id: 5, name: "Git", complete: false },
    ];
    while (true) {
    const actionInput = prompt("Choose an action: Create, Read, Update, Delete, Exit");
    if (actionInput === null) {
        console.log("No action selected. Exiting.");
        break;
    }
    const action = actionInput.toLowerCase();
    if (action === "create") {
        const newName = prompt("Enter course name:");
        if (newName === null || newName.trim() === "") {
            console.log("Cancelled or empty name. Course not created.");
        } else {
            const newCourse = { id: courses.length > 0 ? Math.max(...courses.map(c => c.id)) + 1 : 1, name: newName, complete: false };
            courses.push(newCourse);
            console.log("Course created:", newCourse);
        }
    } else if (action === "read") {
        console.log("Courses:", courses);
        courses.forEach(course => {
            console.log(`ID: ${course.id}, Name: ${course.name}, Complete: ${course.complete}`);
        });
    } else if (action === "update") {
        const updateName = prompt("Enter course name to update:");
        if (updateName !== null) {
            const courseToUpdate = courses.find(course => course.name.toLowerCase() === updateName.toLowerCase());
            if (courseToUpdate) {
                courseToUpdate.complete = true;
                console.log("Course updated:", courseToUpdate);
            } else {
                console.log("Course not found.");
            }
        } else {
            console.log("Update cancelled.");
        }
    } else if (action === "delete") {
        const deleteName = prompt("Enter course name to delete:");
        if (deleteName !== null) {
            const index = courses.findIndex(course => course.name.toLowerCase() === deleteName.toLowerCase());
            if (index !== -1) {
                const deletedCourse = courses.splice(index, 1);
                console.log("Course deleted:", deletedCourse[0]);
            } else {
                console.log("Course not found.");
            }
        } else {
            console.log("Delete cancelled.");
        }
    } else if (action === "exit") {
        console.log("Welcome to Rikkei Education.");
        break;
    } else {
        console.log("Invalid action. Please choose again.");
    }
    }
    