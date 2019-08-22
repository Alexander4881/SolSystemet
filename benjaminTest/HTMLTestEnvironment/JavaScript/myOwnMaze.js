var canvas = document.getElementById("mazecanvas");
var context = canvas.getContext("2d");
var currentX = 0;
var currentY = 0;
var mazeWidthX = 560;
var mazeHeightY = 560;

function mazeStart(X, Y){
    currentX = X;
    currentY = Y;
    updateMaze();
    console.log("mazestart");
};

function updateMaze(){
    var mazeImg = new Image();
    var playerImg = new Image();
    mazeImg.src="../Picture/Mercury.png";
    playerImg.src="../Picture/player.png";

    mazeImg.onload = function(){
        playerImg.onload = function(){
            context.drawImage(mazeImg, 0, 0);
            drawCircles();
            context.drawImage(playerImg, currentX, currentY)
        }
    }
    console.log("update maze");
};

function drawCircles(){
        context.beginPath();
        context.arc(542, 122, 7, 0, 2 * Math.PI, false);
        context.closePath();
        context.fillStyle = '#00FF00';
        context.fill();
};

function movePlayer(e){
    var newX;
    var newY;
    var canMove;
    e = e || window.event;

    console.log("move");

    switch (e.keyCode){
        case 87:
            newX = currentX;
            newY = currentY - 3;
            break;
        case 65:
            newX = currentX - 3;
            newY = currentY;
            break;
        case 83:
            newX = currentX;
            newY = currentY + 3;
            break;
        case 68:
            newX = currentX + 3;
            newY = currentY;
            break;
        default: return;
    }

    canMove = canMoveChecker(newX, newY);
    if (canMove === 1){
        currentX = newX;
        currentY = newY;
        updateMaze();
    }
    else if(canMove === 2){
        makeWhite(0, 0, canvas.width, canvas.height);
        context.textAlign = "center";
        context.textBaseLine = "middle";
        context.fillText("ok asswipe", canvas.width / 2, canvas.height / 2);
        window.removeEventListener("keydown", movePlayer, true);
    }
}

function canMoveChecker(destX, destY){
    var imgData = context.getImageData(destX, destY, 15, 15);
    var colorData = imgData.data;
    var canMove = 1;
    if (destX >= 0 && destX <= mazeWidthX - 15 && destY >= 0 && destY <= mazeHeightY - 15) { // check whether the rectangle would move inside the bounds of the canvas
        for (var i = 0; i < 4 * 15 * 15; i += 4) { // look at all pixels
            if (colorData[i] === 0 && colorData[i + 1] === 0 && colorData[i + 2] === 0) { // black
                canMove = 0; // 0 means: the rectangle can't move
                break;
            }
            else if (colorData[i] === 0 && colorData[i + 1] === 255 && colorData[i + 2] === 0) { // lime: #00FF00
                canMove = 2; // 2 means: the end point is reached
                break;
            }
        }
    }
    else {
        canMove = 0;
    }
    return canMove;
}

function makeWhite(x, y, w, h) {
    context.beginPath();
    context.rect(x, y, w, h);
    context.closePath();
    context.fillStyle = "yellow";
    context.fill();
}

mazeStart(225, 424);
window.addEventListener("keydown", movePlayer, true);