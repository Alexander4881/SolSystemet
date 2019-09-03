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
                <div class="col-sm d-flex justify-content-center"><img src="./images/Mercury.png" height="50"
                                                                       alt="mercury image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./images/Venus.png" height="50"
                                                                       alt="venus image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./images/Earth.png" height="50"
                                                                       alt="earth image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./images/Mars.png" height="50"
                                                                       alt="mars image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./images/Jupiter.png" height="50"
                                                                       alt="jupiter image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./images/Saturn.png" height="50"
                                                                       alt="saturn image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./images/Uranus.png" height="50"
                                                                       alt="uranus image"></div>
                <div class="col-sm d-flex justify-content-center"><img src="./images/Neptune.png" height="50"
                                                                       alt="neptune image"></div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-2"></div>

                <div class="col-sm-8 mt-2">
                    <div class="progress">
                        <div id="rocket-progression" class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar"
                             aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%">
                        </div>
                    </div>
                </div>

                <div class="col-sm-2"></div>
            </div>
        </td>
    </tr>

    <tr class="h-25">
        <td>
            <button type="button" class="btn btn-dark ml-5" onclick="changeRocketPart('head',false)"><</button>
        </td>
        <td rowspan="3">
        </td>
        <td>
            <button type="button" class="btn btn-dark float-right mr-5" onclick="changeRocketPart('head',true)">></button>
        </td>
    </tr>

    <tr class="h-25">
        <td>
            <button type="button" class="btn btn-dark ml-5" onclick="changeRocketPart('body',false)"><</button>
        </td>
        <td>
            <button type="button" class="btn btn-dark float-right mr-5" onclick="changeRocketPart('body',true)">></button>
        </td>
    </tr>

    <tr class="h-25">
        <td>
            <button type="button" class="btn btn-dark ml-5" onclick="changeRocketPart('thruster',false)"><</button>
        </td>
        <td>
            <button type="button" class="btn btn-dark float-right mr-5" onclick="changeRocketPart('thruster',true)">></button>
        </td>
    </tr>
    <tr class="h-10 text-center">
        <td colspan="3"><button type="button" class="btn btn-outline-success">Start Rumraket</button></td>
    </tr>
    </tbody>
</table>

<script src="./resources/javascript/three.js"></script>
<script src="./resources/javascript/LoaderSupport.js"></script>
<script src="./resources/javascript/MTLLoader.js"></script>
<script src="./resources/javascript/OBJLoader2.js"></script>


<script>
    let scene = new THREE.Scene();
    let camera = new THREE.PerspectiveCamera(75, $('#webgl').innerWidth() / $('#webgl').innerHeight(), 0.1, 1000);

    let renderer = new THREE.WebGLRenderer();

    const heads = [constructRocketPart("RocketHead_001", "./CSS/3DObjects/RocketNose_001.obj",
        "./CSS/3DObjects/RocketNose_001.mtl", 9.3, 0, 0, 33),
        constructRocketPart("RocketHead_002", "./CSS/3DObjects/RocketNose_002.obj",
            "./CSS/3DObjects/RocketNose_002.mtl", 9.3, 8, 0, 20),
        constructRocketPart("RocketHead_003", "./CSS/3DObjects/RocketNose_003.obj",
            "./CSS/3DObjects/RocketNose_003.mtl", 9.3, -8, 0, 10)
    ];
    let headSelected = 1;
    heads.forEach(rocketHead => {
        loadOBJ(rocketHead.ObjPath, rocketHead.MltPath, rocketHead.StartPositionY, rocketHead
            .StartPositionX, rocketHead.StartPositionZ, rocketHead.Name);
    });

    const body = [constructRocketPart("Body_001", "./CSS/3DObjects/RocketBody_001.obj",
        "./CSS/3DObjects/RocketBody_001.mtl", 4, 0, 0, 30),
        constructRocketPart("Body_002", "./CSS/3DObjects/RocketBody_002.obj",
            "./CSS/3DObjects/RocketBody_002.mtl", 4, 8, 0, 20),
        constructRocketPart("Body_003", "./CSS/3DObjects/RocketBody_003.obj",
            "./CSS/3DObjects/RocketBody_003.mtl", 4, -8, 0, 12)
    ];
    let bodySelected = 1;
    body.forEach(rocketBody => {
        loadOBJ(rocketBody.ObjPath, rocketBody.MltPath, rocketBody.StartPositionY, rocketBody
            .StartPositionX, rocketBody.StartPositionZ, rocketBody.Name);
    });

    const thruster = [constructRocketPart("Rocket_001", "./CSS/3DObjects/RocketThruster_001.obj",
        "./CSS/3DObjects/RocketThruster_001.mtl", 0, 0, 0, 25),
        constructRocketPart("Rocket_002", "./CSS/3DObjects/RocketThruster_002.obj",
            "./CSS/3DObjects/RocketThruster_002.mtl", 0, 8, 0, 30),
        constructRocketPart("Rocket_003", "./CSS/3DObjects/RocketThruster_003.obj",
            "./CSS/3DObjects/RocketThruster_003.mtl", 0, -8, 0, 33)
    ];
    let thrusterSelected = 1;
    thruster.forEach(rocketThruster => {
        loadOBJ(rocketThruster.ObjPath, rocketThruster.MltPath, rocketThruster.StartPositionY,
            rocketThruster.StartPositionX, rocketThruster.StartPositionZ, rocketThruster.Name);
    });


    var geometry = new THREE.PlaneGeometry(15, 100, 0);
    var material = new THREE.MeshBasicMaterial({
        color: 0xf0f000,
        side: THREE.DoubleSide
    });
    var plane = new THREE.Mesh(geometry, material);
    scene.add(plane);
    plane.position.set(0, 0, -10);

    renderer.setSize($('#webgl').innerWidth(), $('#webgl').innerHeight());
    renderer.setClearColor(0x6ee3f5, 1);
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

    var light = new THREE.PointLight(0xffffff, 1, 200);
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

        $('#rocket-progression').width((heads[headSelected].Value + body[bodySelected].Value + thruster[thrusterSelected].Value) + "%");
    }

    function spaceOBJs(rocketParts) {
        for (i = 0; i < rocketParts.length; i++) {
            console.log(i);
        }
    }

    camera.position.z = 15;
    camera.position.y = 5;

    function animate() {
        requestAnimationFrame(animate);
        renderer.render(scene, camera);
    }
    animate();
</script>

<%@include file="layout/fotter.jsp"%>