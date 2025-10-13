
function processConfirm(answer) {
    let result;
    if (answer) {
        result = "Excellent. We'll play a nice game of chess.";
    } else {
        result = "Maybe later then.";
    }
    return result;
}
//hoi nguoi dung
let confirmAnswer = confirm("Shall we play a game?");
let message = processConfirm(confirmAnswer);
alert(message);





