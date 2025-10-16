const squares = document.querySelectorAll('.square');
    const body = document.body;
    const originalColor = body.style.backgroundColor;

   
    squares.forEach(square => {
      square.addEventListener('mouseover', () => {
       
        body.style.backgroundColor = square.style.backgroundColor;
      });

      square.addEventListener('mouseout', () => {
        
        body.style.backgroundColor = originalColor;
      });
    });
