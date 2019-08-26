var canvas = document.getElementById("mazecanvas");
var context = canvas.getContext("2d");

var red = [255, 0, 0];
var yellow = [0, 255, 0];
var green = [0, 0, 255];
var rgbGoalColors = [red, yellow, green];
const rndNumb = Math.floor(Math.random() * 3);

var mazes = ["../Picture/Mercury.png", "../Picture/Venus.png", "../Picture/Mars.png", "../Picture/Jupiter.png",
"../Picture/Saturn.png", "../Picture/Uranus.png", "../Picture/Neptune.png", "../Picture/Pluto.png"];

var currentX = 0;
var currentY = 0;
var mazeWidthX = 442;
var mazeHeightY = 442;

var mazeImg = new Image();
var playerImg = new Image();

var goalTask="Hvad nummer har merkur i solsystemet, ud fra solen";
var goalSoloution="1";

function loadVariables(maze, goalText, goalAnswer) {
    mazeImg.src=maze;
    playerImg.src="../Picture/player.png";
    goalTask = goalText;
    goalSoloution = goalAnswer;
}

function mazeStart(X, Y){
    currentX = X;
    currentY = Y;
    loadMaze();
    console.log("mazestart");
};

function loadMaze(){
    mazeImg.src=mazes[Math.floor(Math.random()*9)];
    mazeImg.onload = function(){
        updateMaze();
    }
}

function updateMaze(){
    playerImg.src="../Picture/player.png"
    playerImg.onload = function(){
        context.drawImage(mazeImg, 0, 0);
        circleColors();
        context.drawImage(playerImg, currentX, currentY)
    }
    console.log("player moved");
};

function circleColors(){
    switch (rndNumb){
        case 0:
            drawCircles(410, 122, rgbGoalColors[0]);
            drawCircles(12, 12, rgbGoalColors[1]);
            drawCircles(233, 210, rgbGoalColors[2]);
            break;

        case 1:
            drawCircles(410, 122, rgbGoalColors[1]);
            drawCircles(12, 12, rgbGoalColors[2]);
            drawCircles(233, 210, rgbGoalColors[0]);
            break;

        case 2:
            drawCircles(410, 122, rgbGoalColors[2]);
            drawCircles(12, 12, rgbGoalColors[0]);
            drawCircles(233, 210, rgbGoalColors[1]);
            break;
    }
}

function drawCircles(x, y, color){
        context.beginPath();
        context.arc(x, y, 7, 0, 2 * Math.PI, false);
        context.closePath();
        context.fillStyle = "rgb("+color[0]+", "+color[1]+", "+color[2]+")";
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
        loadMaze();
    }
    else if(canMove === 2){
        makeWhite(0, 0, canvas.width, canvas.height);
        context.font = "40px Arial";
        context.fillStyle = "blue";
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
            else if (colorData[i] === selectedGoalColor[0] && colorData[i + 1] === selectedGoalColor[1] && colorData[i + 2] === selectedGoalColor[2]) {
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
    context.fillStyle = "green";
    context.fill();
}

function goalAssigner(){
    makeWhite(0, 442, 442, 90);
    context.font="20px Arial";
    context.fillStyle="yellow";
    context.textAlign="center";
    context.textBaseLine="middle";
    context.fillText(goalTask, 221, mazeHeightY+20, 300);
    context.fillText(goalSoloution+" = rød", 221, mazeHeightY+40, 300);
    context.fillText(Math.floor(Math.random() * 10)+" = grøn", 221, mazeHeightY+60, 300);
    context.fillText(Math.floor(Math.random() * 10)+" = blå", 221, mazeHeightY+80, 300);
}

//loadVariables();
mazeStart(225, 424);
window.addEventListener("keydown", movePlayer, true);
goalAssigner();