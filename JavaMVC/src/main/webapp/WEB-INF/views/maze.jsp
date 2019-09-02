    <%--
      Created by IntelliJ IDEA.
      User: benj4539
      Date: 30-08-2019
      Time: 10:45
      To change this template use File | Settings | File Templates.
    --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <%@include file="layout/header.jsp"%>

        <h2>${test}</h2>

    <canvas width="800" height="600" id="mazecanvas">Can't load the maze game, because your browser doesn't support HTML5.</canvas>
    <noscript>JavaScript is not enabled. To play the game, you should enable it.</noscript>
    <script src="./resources/javascript/jquery-3.4.1.js"></script>

        <script>
        var canvas = document.getElementById("mazecanvas");
        var context = canvas.getContext("2d");

        var red = [255, 0, 0];
        var green = [0, 255, 0];
        var blue = [0, 0, 255];
        var rgbGoalColors = [red, green, blue];
        const mapColorRnd = Math.floor(Math.random() * 3);
        const correctColorRnd = Math.floor(Math.random() * 3);
        const selectedGoalColor = rgbGoalColors[correctColorRnd];

        const selectedQuestion = Math.floor(Math.random()*2);

        var currentX = 0;
        var currentY = 0;
        var mazeWidthX = 442;
        var mazeHeightY = 442;

        var mazeImgSrc;
        var mazeImg = new Image();
        var playerImg = new Image();
        var goalTask;
        var goalSoloution;
        var fillerAnswers;

        var counter = 0;
        <c:forEach var="maze" items="${mazeInfo}">
        if (counter === selectedQuestion){
                mazeImgSrc="${maze.imgSrc}";
                goalTask = "${maze.questionText}";
                goalSoloution = "${maze.answer}";
        }
        counter++;
        </c:forEach>
        if (selectedQuestion === 1){
                fillerAnswers = [goalSoloution+3, goalSoloution-2];
        }
        else{
                if(goalSoloution === "Solid"){
                        fillerAnswers = ["Gas", "Sol"];
                }
                else if(goalSoloution === "Gas"){
                        fillerAnswers = ["Solid", "Dværg"];
                }
                else if(goalSoloution === "Dværg"){
                        fillerAnswers = ["Gas", "Solid"];
                }
        }

        function mazeStart(X, Y){
        currentX = X;
        currentY = Y;
        loadMaze();
        console.log("mazestart");
        }

        function loadMaze(){
        mazeImg.src=mazeImgSrc;
        mazeImg.onload = function(){
        updateMaze();
        }
        }

        function updateMaze(){
        playerImg.src="./resources/images/player.png";
        playerImg.onload = function(){
        context.drawImage(mazeImg, 0, 0);
        circleColors();
        context.drawImage(playerImg, currentX, currentY)
        }
        console.log("player moved");
        };

        function circleColors(){
        switch (mapColorRnd){
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
        context.fillText("Godt klaret, du vil blive sendt tilbage om lidt", canvas.width / 2, canvas.height / 2);
        window.removeEventListener("keydown", movePlayer, true);
                sleep(5000).then(() => {
                        history.go(-1);
                })
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

        switch(correctColorRnd){
        case 0:
        context.fillText(goalSoloution+" = rød", 221, mazeHeightY+40, 300);
        context.fillText(fillerAnswers[0]+" = grøn", 221, mazeHeightY+60, 300);
        context.fillText(fillerAnswers[1]+" = blå", 221, mazeHeightY+80, 300);
        break;

        case 1:
        context.fillText(fillerAnswers[1]+" = rød", 221, mazeHeightY+40, 300);
        context.fillText(goalSoloution+" = grøn", 221, mazeHeightY+60, 300);
        context.fillText(fillerAnswers[0]+" = blå", 221, mazeHeightY+80, 300);
        break;

        case 2:
        context.fillText(fillerAnswers[0]+" = rød", 221, mazeHeightY+40, 300);
        context.fillText(fillerAnswers[1]+" = grøn", 221, mazeHeightY+60, 300);
        context.fillText(goalSoloution+" = blå", 221, mazeHeightY+80, 300);
        break;
        }
        }

        const sleep = (milliseconds) => {
                return new Promise(resolve => setTimeout(resolve, milliseconds))
        }

        //loadVariables();
        mazeStart(225, 424);
        window.addEventListener("keydown", movePlayer, true);
        goalAssigner();
        </script>

        <%@include file="layout/fotter.jsp"%>

