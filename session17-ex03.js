const modal = document.getElementById("myModal");
    const btn = document.getElementById("openModalBtn");
    const span = document.getElementsByClassName("close")[0];

    // Khi nhấn nút, mở modal
    btn.onclick = function() {
      modal.style.display = "block";
    }

    // Khi nhấn dấu X, đóng modal
    span.onclick = function() {
      modal.style.display = "none";
    }

    // Khi nhấn ra ngoài vùng modal, cũng đóng
    window.onclick = function(event) {
      if (event.target === modal) {
        modal.style.display = "none";
      }
    }