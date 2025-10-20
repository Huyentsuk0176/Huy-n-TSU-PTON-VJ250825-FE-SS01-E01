
// ======= Khởi tạo dữ liệu mẫu ban đầu 
    const defaultTasks = [
      { id: 1, content: "Learn Javascript Session 01", dueDate: "2023-04-17", status: "Pending", assignedTo: "Anh Bách" },
      { id: 2, content: "Learn Javascript Session 2", dueDate: "2023-04-17", status: "Pending", assignedTo: "Lâm th" },
      { id: 3, content: "Learn CSS Session 1", dueDate: "2023-04-17", status: "Pending", assignedTo: "Hiếu Cị ớt ớt" },
    ];
    let task = JSON.parse(localStorage.getItem("task")) || defaultTasks;
    function saveTasks() {
        localStorage.setItem("task", JSON.stringify(task));
    }
    function renderTasks() {
        const tbody = document.getElementById("taskTable");
        tbody.innerHTML = "";
        task.forEach((task) => {
            const row = `
            <tr>
                <td>${task.id}</td>
                <td>${task.content}</td>
                <td>${task.dueDate}</td>
                <td>${task.status}</td>
                <td>${task.assignedTo}</td>
                <td>
                <button class="edit-btn" onclick="editTask(${task.id})">Sửa</button>
                <button class="delete-btn" onclick="deleteTask(${task.id})">Xóa</button>
                </td>
            </tr>
            `;
            tbody.innerHTML += row;
        });
    }
    document.getElementById("taskForm").addEventListener("submit", function (e) {
        e.preventDefault();
        const id = document.getElementById("taskId").value;
        const content = document.getElementById("content").value;
        const dueDate = document.getElementById("dueDate").value;
        const status = document.getElementById("status").value;
        const assignedTo = document.getElementById("assignedTo").value;
        if (id) {
            const index = task.findIndex((t) => t.id == id);
            task[index] = { id: Number(id), content, dueDate, status, assignedTo };
        } else {
            const newTask = {
                id: task.length ? task[task.length - 1].id + 1 : 1,
                content,
                dueDate,
                status,
                assignedTo,
            };
            task.push(newTask);
        }
        saveTasks();
        renderTasks();
        this.reset();
        document.getElementById("taskId").value = "";
    });
    function editTask(id) {
        const task = task.find((t) => t.id === id);
        document.getElementById("taskId").value = task.id;
        document.getElementById("content").value = task.content;
        document.getElementById("dueDate").value = task.dueDate;
        document.getElementById("status").value = task.status;
        document.getElementById("assignedTo").value = task.assignedTo;
    }
    function deleteTask(id) {
        if (confirm("Bạn có chắc muốn xóa công việc này không?")) {
            task = task.filter((t) => t.id !== id);
            saveTasks();
            renderTasks();
        }
    }
    renderTasks();







    