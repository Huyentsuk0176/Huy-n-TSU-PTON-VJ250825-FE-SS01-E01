
function run(choice) {
      switch(choice) {
        case 1: // Độ C -> Độ F
          let c = parseFloat(prompt("Nhập nhiệt độ C:"));
          let f = c * 9/5 + 32;
          console.log(`${c}°C = ${f}°F`);
          break;

        case 2: // Mét -> Feet
          let m = parseFloat(prompt("Nhập số mét:"));
          let feet = m * 3.2808;
          console.log(`${m} mét = ${feet} feet`);
          break;

        case 3: // Diện tích hình vuông
          let a = parseFloat(prompt("Nhập cạnh a:"));
          console.log(`Diện tích hình vuông = ${a*a}`);
          break;

        case 4: // Diện tích HCN
          let chieuDai = parseFloat(prompt("Nhập cạnh a:"));
          let chieuRong = parseFloat(prompt("Nhập cạnh b:"));
          console.log(`Diện tích HCN = ${chieuDai * chieuRong}`);
          break;

        case 5: // Diện tích tam giác vuông
          let canhA = parseFloat(prompt("Nhập cạnh a:"));
          let canhB = parseFloat(prompt("Nhập cạnh b:"));
          console.log(`Diện tích tam giác vuông = ${0.5 * canhA * canhB}`);
          break;

        case 6: // PT bậc 1
          let a1 = parseFloat(prompt("Nhập a:"));
          let b1 = parseFloat(prompt("Nhập b:"));
          if (a1 === 0) {
            if (b1 === 0) console.log("PT vô số nghiệm");
            else console.log("PT vô nghiệm");
          } else {
            console.log(`Nghiệm x = ${-b1 / a1}`);
          }
          break;

        case 7: // PT bậc 2
          let a2 = parseFloat(prompt("Nhập a:"));
          let b2 = parseFloat(prompt("Nhập b:"));
          let c2 = parseFloat(prompt("Nhập c:"));
          if (a2 === 0) {
            if (b2 === 0) {
              console.log(c2 === 0 ? "PT vô số nghiệm" : "PT vô nghiệm");
            } else {
              console.log(`Nghiệm x = ${-c2/b2}`);
            }
          } else {
            let delta = b2*b2 - 4*a2*c2;
            if (delta < 0) console.log("PT vô nghiệm");
            else if (delta === 0) console.log(`PT có nghiệm kép x = ${-b2/(2*a2)}`);
            else {
              let x1 = (-b2 + Math.sqrt(delta))/(2*a2);
              let x2 = (-b2 - Math.sqrt(delta))/(2*a2);
              console.log(`PT có 2 nghiệm: x1 = ${x1}, x2 = ${x2}`);
            }
          }
          break;

        case 8: // Kiểm tra tuổi
          let age = parseInt(prompt("Nhập tuổi:"));
          if (age > 0 && age < 120) console.log("Tuổi hợp lệ");
          else console.log("Tuổi không hợp lệ");
          break;
      }
    }