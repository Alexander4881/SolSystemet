<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%@include file="layout/header.jsp"%>

<div id="webgl" class="w-100 h-100"></div>
<table class="w-100 h-100 controls">

    <thead>
    <th class="w-5"></th>
    <th class="w-90"></th>
    <th class="w-5"></th>
    </thead>
    <tbody>
    <tr class="h-10">
        <td colspan="3">
            <h1 class="display-4 text-center">byg din egen rumraket</h1>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./resources/images/Mercury.png" height="50"
                                                                       alt="mercury image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./resources/images/Venus.png" height="50"
                                                                       alt="venus image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./resources/images/Earth.png" height="50"
                                                                       alt="earth image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./resources/images/Mars.png" height="50"
                                                                       alt="mars image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./resources/images/Jupiter.png" height="50"
                                                                       alt="jupiter image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./resources/images/Saturn.png" height="50"
                                                                       alt="saturn image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./resources/images/Uranus.png" height="50"
                                                                       alt="uranus image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./resources/images/Neptune.png" height="50"
                                                                       alt="neptune image"></div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-2"></div>

                <div class="col-sm-8 mt-2">
                    <div class="progress">
                        <div id="rocket-progression" class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar"
                             aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 75%">
                        </div>
                    </div>
                </div>

                <div class="col-sm-2"></div>
            </div>
        </td>
    </tr>

    <tr class="h-25">
        <td>
            <button type="button" class="btn btn-outline-success ml-5" onclick="changeRocketPart('head',false)"><</button>
        </td>
        <td rowspan="3">
        </td>
        <td>
            <button type="button" class="btn btn-outline-success float-right mr-5" onclick="changeRocketPart('head',true)">></button>
        </td>
    </tr>

    <tr class="h-25">
        <td>
            <button type="button" class="btn btn-outline-success ml-5" onclick="changeRocketPart('body',false)"><</button>
        </td>
        <td>
            <button type="button" class="btn btn-outline-success float-right mr-5" onclick="changeRocketPart('body',true)">></button>
        </td>
    </tr>

    <tr class="h-25">
        <td>
            <button type="button" class="btn btn-outline-success ml-5" onclick="changeRocketPart('thruster',false)"><</button>
        </td>
        <td>
            <button type="button" class="btn btn-outline-success float-right mr-5" onclick="changeRocketPart('thruster',true)">></button>
        </td>
    </tr>
    <tr class="h-10 text-center">
        <td colspan="3">
            <button type="button" onclick="playButton()" class="btn btn-outline-success">Start Rumraket</button>
        </td>
    </tr>
    </tbody>
</table>

<script src="./resources/javascript/three.js"></script>
<script src="<c:url value="/resources/javascript/LoaderSupport.js"/>"></script>
<script src="<c:url value="/resources/javascript/MTLLoader.js"/>"></script>
<script src="<c:url value="/resources/javascript/OBJLoader2.js"/>"></script>
<script src="<c:url value="/resources/javascript/tween.js"/>"></script>


<script>
    let scene = new THREE.Scene();
    let camera = new THREE.PerspectiveCamera(45, $('#webgl').innerWidth() / $('#webgl').innerHeight(), 0.1, 1000);
    let playAsteroids, cameraTransitions = false;

    let renderer = new THREE.WebGLRenderer();

    const heads = [
        <c:forEach var="rocketPart" items="${parts}">
            <c:if test="${rocketPart.rocketPartType=='Nose'}">
                constructRocketPart("${rocketPart.name}", "${rocketPart.objPath}", "${rocketPart.mtlPath}", ${rocketPart.positionY}, ${rocketPart.positionX}, ${rocketPart.positionZ},${rocketPart.power}),
            </c:if>
        </c:forEach>
    ];
    let headSelected = 0;
    heads.forEach(rocketHead => {
        loadOBJ(rocketHead.ObjPath, rocketHead.MltPath, rocketHead.StartPositionY, rocketHead
            .StartPositionX, rocketHead.StartPositionZ, rocketHead.Name);
    });

    const body = [
        <c:forEach var="rocketPart" items="${parts}">
            <c:if test="${rocketPart.rocketPartType=='Body'}">
                constructRocketPart("${rocketPart.name}", "${rocketPart.objPath}", "${rocketPart.mtlPath}", ${rocketPart.positionY}, ${rocketPart.positionX}, ${rocketPart.positionZ}, ${rocketPart.power}),
            </c:if>
        </c:forEach>
    ];
    let bodySelected = 0;
    body.forEach(rocketBody => {
        loadOBJ(rocketBody.ObjPath, rocketBody.MltPath, rocketBody.StartPositionY, rocketBody
            .StartPositionX, rocketBody.StartPositionZ, rocketBody.Name);
    });

    const thruster = [
        <c:forEach var="rocketPart" items="${parts}">
            <c:if test="${rocketPart.rocketPartType=='Thruster'}">
                constructRocketPart("${rocketPart.name}", "${rocketPart.objPath}", "${rocketPart.mtlPath}", ${rocketPart.positionY}, ${rocketPart.positionX}, ${rocketPart.positionZ}, ${rocketPart.power}),
            </c:if>
        </c:forEach>
    ];
    let thrusterSelected = 0;
    thruster.forEach(rocketThruster => {
        loadOBJ(rocketThruster.ObjPath, rocketThruster.MltPath, rocketThruster.StartPositionY,
            rocketThruster.StartPositionX, rocketThruster.StartPositionZ, rocketThruster.Name);
    });

    const loader = new THREE.TextureLoader();
    <c:forEach var="planet" items="${planets}">
    let ${planet.name}Geometry = new THREE.SphereGeometry( ${planet.size}, 48, 48 );
    loader.load('${planet.textureSrc}', (texture) => {
        const material = new THREE.MeshBasicMaterial({
            map: texture,
        });
        const ${planet.name} = new THREE.Mesh(${planet.name}Geometry, material);
        ${planet.name}.name = "${planet.name}";
        ${planet.name}.position.set(${planet.size + 20},${planet.distanceFromCenter + 400},0);
        ${planet.name}.rotateX(1.5707963268);
        scene.add(${planet.name});

    });
    </c:forEach>

    let geometry = new THREE.PlaneGeometry(15, 100, 0);
    let material = new THREE.MeshBasicMaterial({
        color: 0xf0f000,
        side: THREE.DoubleSide
    });
    var plane = new THREE.Mesh(geometry, material);
    plane.name = "background";
    scene.add(plane);
    plane.position.set(0, 0, -10);

    renderer.setSize($('#webgl').innerWidth(), $('#webgl').innerHeight());
    renderer.setClearColor(0x204dc9, 1);
    $('#webgl').append(renderer.domElement);

    /**
     * This eliminates the redundance of having to type property names for a planet object.
     * @param {type} myName string
     * @param {type} myObjPath
     * @param {type} myMtlPath
     * @param {type} myStartPositionY
     * @param {type} myStartPositionX
     * @param {type} myStartPositionZ
     * @returns {constructRocketPart.mainAnonym$0}
     */
    function constructRocketPart(myName, myObjPath, myMtlPath, myStartPositionY, myStartPositionX,
                                 myStartPositionZ, myValue) {
        return {
            Name: myName,
            ObjPath: myObjPath,
            MltPath: myMtlPath,
            StartPositionY: myStartPositionY,
            StartPositionX: myStartPositionX,
            StartPositionZ: myStartPositionZ,
            Value:myValue
        };
    }

    function loadOBJ(objPath, mtlPath, positionY, positionX, positionZ, name) {
        const objLoader = new THREE.OBJLoader2();
        objLoader.loadMtl(mtlPath, null, (materials) => {
            objLoader.setMaterials(materials);
            objLoader.load(objPath, (event) => {
                const root = event.detail.loaderRootNode;
                root.position.set(positionX, positionY, positionZ);
                root.name = name;
                scene.add(root);
            });
        });
    }

    let light = new THREE.PointLight(0xffffff, 1, 200);
    light.position.set(50, 50, 50);
    scene.add(light);

    function changeRocketPart(rocketPart, forward) {
        switch (rocketPart) {
            case "head":
                if (forward) {
                    if (headSelected < heads.length - 1) {
                        heads.forEach(rocketHead => {
                            var screenObj = scene.getObjectByName(rocketHead.Name);
                            screenObj.translateX(8);
                        });
                        headSelected++;
                    }
                } else {
                    if (headSelected >= 1) {
                        headSelected--;
                        heads.forEach(rocketHead => {
                            var screenObj = scene.getObjectByName(rocketHead.Name);
                            screenObj.translateX(-8);
                        });
                    }
                }
                break;

            case "body":
                if (forward) {
                    if (bodySelected < body.length - 1) {
                        body.forEach(rocketBody => {
                            var screenObj = scene.getObjectByName(rocketBody.Name);
                            screenObj.translateX(8);
                        });
                        bodySelected++;
                    }
                } else {
                    if (bodySelected >= 1) {
                        bodySelected--;
                        body.forEach(rocketBody => {
                            var screenObj = scene.getObjectByName(rocketBody.Name);
                            screenObj.translateX(-8);
                        });
                    }
                }
                break;

            case "thruster":
                if (forward) {
                    if (thrusterSelected < thruster.length - 1) {
                        thruster.forEach(rocketThruster => {
                            var screenObj = scene.getObjectByName(rocketThruster.Name);
                            screenObj.translateX(8);
                        });
                        thrusterSelected++;
                    }
                } else {

                    if (thrusterSelected >= 1) {
                        thrusterSelected--;
                        thruster.forEach(rocketThruster => {
                            var screenObj = scene.getObjectByName(rocketThruster.Name);
                            screenObj.translateX(-8);
                        });
                    }
                }
                break;

            default:
                console.error("not valid paramerters");
                break;
        }
        // update the planet progression bar
        setProgressionBar();
    }

    function setProgressionBar(){

        $("#rocket-progression").width((heads[headSelected].Value + body[bodySelected].Value + thruster[thrusterSelected].Value) + "%");
    }

    // hide the controls make an animation
    function hideControls() {
        $(".controls").hide();
    }

    function removeEntity(name) {
        console.log("removing element " + name);
        let selectedObject = scene.getObjectByName(name);
        scene.remove( selectedObject );
        animate();
    }

    function removeNotSelected() {
        for (let i = 0; i < heads.length; i++){
            if (i !== headSelected){
                removeEntity(heads[i].Name)
            }
        }

        for (let i = 0; i < body.length; i++){
            if (i !== bodySelected){
                removeEntity(body[i].Name)
            }
        }

        for (let i = 0; i < thruster.length; i++){
            if (i !== thrusterSelected){
                removeEntity(thruster[i].Name)
            }
        }
    }

    function playButton(){
        hideControls();
        playAsteroids = true;
        cameraTransitions = true;

        let selectedHead = heads[headSelected];
        let selectedBody = body[bodySelected];
        let selectedThruster = thruster[thrusterSelected];

        removeEntity("background");

        removeNotSelected();

        let position = { x : 0, y: 5, z: 15 };
        let target = { x : 0, y: 5, z:4 };
        let tween = new TWEEN.Tween(position).to(target, 2000);

        tween.onUpdate(function(){
            camera.position.set(position.x,position.y,position.z);
        });
        tween.start();

        let color = { r : 32, g: 77, b: 201 };
        let targetColor = { r : 0, g: 0, b:0 };
        let colorTween = new TWEEN.Tween(color).to(targetColor, 2000);

        colorTween.onUpdate(function(){
            renderer.setClearColor(new THREE.Color("rgb("+Math.round(color.r)+", "+Math.round(color.g)+", "+Math.round(color.b)+")"));
        });
        colorTween.start();

        let lookPosition = { x : 0, y: -5, z: 0 };
        let lookTarget = { x : 0, y: 300, z:0 };
        let lookTween = new TWEEN.Tween(lookPosition).to(lookTarget, 2000);
        lookTween.onUpdate(function () {
            camera.lookAt(new THREE.Vector3(lookPosition.x,lookPosition.y,lookPosition.z));
        });
        lookTween.onComplete(function () {
            let movePosition = { y: 5 };
            let moveTarget = { y: 520 };
            let moveTween = new TWEEN.Tween(movePosition).to(moveTarget, 60000);
            moveTween.onUpdate(function () {
                camera.position.set(0 , movePosition.y, 4);

                scene.getObjectByName(selectedHead.Name).position.y = movePosition.y + selectedHead.StartPositionY;
                scene.getObjectByName(selectedBody.Name).position.y = movePosition.y + selectedBody.StartPositionY;
                scene.getObjectByName(selectedThruster.Name).position.y = movePosition.y + selectedThruster.StartPositionY;

                scene.children[0].position.y = movePosition.y + 50;
            });
            moveTween.onComplete(function () {
                cameraTransitions = false;
                console.log("done");
            });
            moveTween.start();

        });
        lookTween.start();
    }

    camera.position.z = 15;
    camera.position.y = 5;

    function animate() {
        requestAnimationFrame(animate);

        if (playAsteroids){
            if (cameraTransitions){
                TWEEN.update();
            }
        }

        renderer.render(scene, camera);
    }
    animate();
</script>

<%@include file="layout/fotter.jsp"%>