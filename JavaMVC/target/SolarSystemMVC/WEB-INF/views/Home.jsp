<%--
  Created by IntelliJ IDEA.
  User: alihn
  Date: 14-08-2019
  Time: 18:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%@include file="layout/header.jsp"%>

<div class="planet-overview">
    <!-- sun -->
    <div class="row" onclick="setPlanetIntersects('Solen')">
        <img src="./resources/images/Sun.png" />
    </div>

    <!-- mercury -->
    <div class="row" onclick="setPlanetIntersects('Merkur')">
        <img src="./resources/images/Mercury.png" />
    </div>

    <!-- venus -->
    <div class="row" onclick="setPlanetIntersects('Venus')">
        <img src="./resources/images/Venus.png" />
    </div>

    <!-- earth -->
    <div class="row" onclick="setPlanetIntersects('Jorden')">
        <img src="./resources/images/Earth.png" />
    </div>

    <!-- mars -->
    <div class="row" onclick="setPlanetIntersects('Mars')">
        <img src="./resources/images/Mars.png" />
    </div>

    <!-- jupiter -->
    <div class="row" onclick="setPlanetIntersects('Jupiter')">
        <img src="./resources/images/Jupiter.png" />
    </div>

    <!-- saturn -->
    <div class="row" onclick="setPlanetIntersects('Saturn')">
        <img src="./resources/images/Saturn.png" />
    </div>

    <!-- uranus -->
    <div class="row" onclick="setPlanetIntersects('Uranus')">
        <img src="./resources/images/Uranus.png" />
    </div>

    <!-- neptune -->
    <div class="row" onclick="setPlanetIntersects('Neptun')">
        <img src="./resources/images/Neptune.png" />
    </div>

    <!-- pluto -->
    <div class="row" onclick="setPlanetIntersects('Pluto')">
        <img src="./resources/images/Pluto.png" />
    </div>

</div>

<div class="container-fluid">

    <c:forEach var="planet" items="${planets}">
        <div id="${planet.name}" class="planet-information hide">
            <div class="container text-danger">
                <h1 class="display-2">${planet.name}</h1>
                <p class="text-justify">
                    ${planet.description}
                </p>

                <div class="card" style="width: 18rem;">
                    <div class="card-body">
                        <h5 class="card-title">Diameter ${planet.diameterMeasuringUnit}</h5>
                        <h6 class="card-subtitle mb-2 text-muted">${planet.diameterFullMeasuringUnit}</h6>
                        <p class="card-text">${planet.diameterDescription}</p>
                    </div>
                </div>

            </div>
        </div>
    </c:forEach>

    <div id="webgl" class="h-100"></div>
</div>

<script src="<c:url value="/resources/javascript/three.js"/>"></script>
<script src="<c:url value="/resources/javascript/OrbitControls.js"/>"></script>
<script>
    var pointLight, controls, scene, camera, renderer;
    var planetSegments = 48;
    var mouse = new THREE.Vector2(), raycaster;

    <c:forEach var="planet" items="${planets}">
        var ${planet.name}, ${planet.name}Orbit;
        var ${planet.name}Data = constructPlanetData(${planet.orbitRate}, ${planet.rotationSpeed}, ${planet.distanceFromCenter}, "${planet.name}", "${planet.textureSrc}", ${planet.size}, planetSegments);
        <c:forEach var="moon" items="${planet.moons}">
            var ${moon.name}, ${moon.name}Orbit;
            var ${moon.name}Data = constructPlanetData(${moon.orbitRate}, ${moon.rotationRate}, ${moon.distanceFromPlanet}, "${moon.name}", "${moon.textureSrc}", ${moon.size}, planetSegments);
        </c:forEach>
    </c:forEach>

    var orbitData = {
        value: 200,
        runOrbit: true,
        runRotation: true
    };

    var clock = new THREE.Clock();

    /**
     * This eliminates the redundance of having to type property names for a planet object.
     * @param {type} myOrbitRate decimal
     * @param {type} myRotationRate decimal
     * @param {type} myDistanceFromAxis decimal
     * @param {type} myName string
     * @param {type} myTexture image file path
     * @param {type} mySize decimal
     * @param {type} mySegments integer
     * @returns {constructPlanetData.mainAnonym$0}
     */
    function constructPlanetData(myOrbitRate, myRotationRate, myDistanceFromAxis, myName, myTexture, mySize, mySegments) {
        return {
            orbitRate: myOrbitRate,
            rotationRate: myRotationRate,
            distanceFromAxis: myDistanceFromAxis,
            name: myName,
            texture: myTexture,
            size: mySize,
            segments: mySegments
        };
    }

    /**
     * create a visible ring and add it to the scene.
     * @param {type} size decimal
     * @param {type} innerDiameter decimal
     * @param {type} facets integer
     * @param {type} myColor HTML color
     * @param {type} name string
     * @param {type} distanceFromAxis decimal
     * @returns {THREE.Mesh|myRing}
     */
    function getRing(size, innerDiameter, facets, myColor, name, distanceFromAxis) {
        var ring1Geometry = new THREE.RingGeometry(size, innerDiameter, facets);
        var ring1Material = new THREE.MeshBasicMaterial({
            color: myColor,
            side: THREE.DoubleSide
        });
        var myRing = new THREE.Mesh(ring1Geometry, ring1Material);
        myRing.name = name;
        myRing.position.set(distanceFromAxis, 0, 0);
        myRing.rotation.x = Math.PI / 2;
        scene.add(myRing);
        return myRing;
    }

    /**
     * Used to create a three dimensional ring. This takes more processing power to
     * run that getRing(). So use this sparingly, such as for the outermost ring of
     * Saturn.
     * @param {type} size decimal
     * @param {type} innerDiameter decimal
     * @param {type} facets integer
     * @param {type} myColor HTML color
     * @param {type} name string
     * @param {type} distanceFromAxis decimal
     * @returns {THREE.Mesh|myRing}
     */
    function getTube(size, innerDiameter, facets, roundness, myColor, name, distanceFromAxis) {
        var ringGeometry = new THREE.TorusGeometry(size, innerDiameter, facets, roundness);
        var ringMaterial = new THREE.MeshBasicMaterial({
            color: myColor,
            side: THREE.DoubleSide
        });
        myRing = new THREE.Mesh(ringGeometry, ringMaterial);
        myRing.name = name;
        myRing.position.set(distanceFromAxis, 0, 0);
        myRing.rotation.x = Math.PI / 2;
        scene.add(myRing);
        return myRing;
    }

    /**
     * Simplifies the creation of materials used for visible objects.
     * @param {type} type
     * @param {type} color
     * @param {type} myTexture
     * @returns {THREE.MeshStandardMaterial|THREE.MeshLambertMaterial|THREE.MeshPhongMaterial|THREE.MeshBasicMaterial}
     */
    function getMaterial(type, color, myTexture) {
        var materialOptions = {
            color: color === undefined ? 'rgb(255, 255, 255)' : color,
            map: myTexture === undefined ? null : myTexture
        };

        switch (type) {
            case 'basic':
                return new THREE.MeshBasicMaterial(materialOptions);
            case 'lambert':
                return new THREE.MeshLambertMaterial(materialOptions);
            case 'phong':
                return new THREE.MeshPhongMaterial(materialOptions);
            case 'standard':
                return new THREE.MeshStandardMaterial(materialOptions);
            default:
                return new THREE.MeshBasicMaterial(materialOptions);
        }
    }

    /**
     *  Draws all of the orbits to be shown in the scene.
     * @returns {undefined}
     */
    function createVisibleOrbits() {
        var orbitWidth = 0.1;

        <c:forEach var="planet" items="${planets}">
        ${planet.name}Orbit = getRing(${planet.name}Data.distanceFromAxis + orbitWidth, ${planet.name}Data.distanceFromAxis - orbitWidth, 320, 0xffffff, "${planet.name}Orbit", 0);
        </c:forEach>

    }

    /**
     * Simplifies the creation of a sphere.
     * @param {type} material THREE.SOME_TYPE_OF_CONSTRUCTED_MATERIAL
     * @param {type} size decimal
     * @param {type} segments integer
     * @returns {getSphere.obj|THREE.Mesh}
     */
    function getSphere(material, size, segments) {
        var geometry = new THREE.SphereGeometry(size, segments, segments);
        var obj = new THREE.Mesh(geometry, material);
        obj.castShadow = true;

        return obj;
    }

    /**
     * Creates a planet and adds it to the scene.
     * @param {type} myData data for a planet object
     * @param {type} x integer
     * @param {type} y integer
     * @param {type} z integer
     * @param {type} myMaterialType string that is passed to getMaterial()
     * @returns {getSphere.obj|THREE.Mesh|loadTexturedPlanet.myPlanet}
     */
    function loadTexturedPlanet(myData, x, y, z, myMaterialType) {
        var myMaterial;
        var passThisTexture;

        if (myData.texture && myData.texture !== "") {
            passThisTexture = new THREE.TextureLoader().load(myData.texture);
        }
        if (myMaterialType) {
            myMaterial = getMaterial(myMaterialType, "rgb(255, 255, 255 )", passThisTexture);
        } else {
            myMaterial = getMaterial("lambert", "rgb(255, 255, 255 )", passThisTexture);
        }

        myMaterial.receiveShadow = true;
        myMaterial.castShadow = true;
        var myPlanet = getSphere(myMaterial, myData.size, myData.segments);
        myPlanet.receiveShadow = true;
        myPlanet.name = myData.name;
        scene.add(myPlanet);
        myPlanet.position.set(x, y, z);

        return myPlanet;
    }

    /**
     * Simplifies creating a light that disperses in all directions.
     * @param {type} intensity decimal
     * @param {type} color HTML color
     * @returns {THREE.PointLight|getPointLight.light}
     */
    function getPointLight(intensity, color) {
        var light = new THREE.PointLight(color, intensity);
        light.castShadow = true;

        light.shadow.bias = 0.001;
        light.shadow.mapSize.width = 2048;
        light.shadow.mapSize.height = 2048;
        return light;
    }

    /**
     * Move the planet around its orbit, and rotate it.
     * @param {type} myPlanet
     * @param {type} myData
     * @param {type} myTime
     * @param {type} stopRotation optional set to true for rings
     * @returns {undefined}
     */
    function movePlanet(myPlanet, myData, myTime, stopRotation) {
        if (orbitData.runRotation && !stopRotation) {
            myPlanet.rotation.y += myData.rotationRate;
        }
        if (orbitData.runOrbit) {
            myPlanet.position.x = Math.cos(myTime *
                (1.0 / (myData.orbitRate * orbitData.value)) + 10.0) *
                myData.distanceFromAxis;
            myPlanet.position.z = Math.sin(myTime *
                (1.0 / (myData.orbitRate * orbitData.value)) + 10.0) *
                myData.distanceFromAxis;
        }
    }

    /**
     * Move the moon around its orbit with the planet, and rotate it.
     * @param {type} myMoon
     * @param {type} myPlanet
     * @param {type} myData
     * @param {type} myTime
     * @returns {undefined}
     */
    function moveMoon(myMoon, myPlanet, myData, myTime) {
        movePlanet(myMoon, myData, myTime);
        if (orbitData.runOrbit) {
            myMoon.position.x = myMoon.position.x + myPlanet.position.x;
            myMoon.position.z = myMoon.position.z + myPlanet.position.z;
        }
    }


    /**
     * This is the function that starts everything.
     * @returns {THREE.Scene|scene}
     */
    function init() {
        // Create the camera that allows us to view into the scene.
        camera = new THREE.PerspectiveCamera(
            45, // field of view
            $('#webgl').innerWidth() / $('#webgl').innerHeight(), // aspect ratio
            1, // near clipping plane
            1000 // far clipping plane
        );
        camera.position.z = 60;
        camera.position.x = 150;
        camera.position.y = 30;
        camera.lookAt(new THREE.Vector3(0, 0, 0));

        raycaster = new THREE.Raycaster();
        intersects = null;
        // Create the scene that holds all of the visible objects.
        scene = new THREE.Scene();

        // Create the renderer that controls animation.
        renderer = new THREE.WebGLRenderer();
        renderer.setSize($('#webgl').innerWidth(), $('#webgl').innerHeight());

        // Attach the renderer to the div element.
        document.getElementById('webgl').appendChild(renderer.domElement);

        // Create controls that allows a user to move the scene with a mouse.
        controls = new THREE.OrbitControls(camera, renderer.domElement);
        controls.target.set(0, 0, 0);

        // Load the images used in the background.
        var path = './resources/cubemap/';
        var format = '.jpg';
        var urls = [
            path + 'px' + format, path + 'nx' + format,
            path + 'py' + format, path + 'ny' + format,
            path + 'pz' + format, path + 'nz' + format
        ];
        var reflectionCube = new THREE.CubeTextureLoader().load(urls);
        reflectionCube.format = THREE.RGBFormat;

        // Attach the background cube to the scene.
        scene.background = reflectionCube;

        // Create light from the sun.
        pointLight = getPointLight(1.5, "rgb(255, 220, 180)");
        scene.add(pointLight);

        // Create light that is viewable from all directions.
        var ambientLight = new THREE.AmbientLight(0xaaaaaa);
        scene.add(ambientLight);

        <c:forEach var="planet" items="${planets}">
        ${planet.name} = loadTexturedPlanet(${planet.name}Data, ${planet.name}Data.distanceFromAxis, 0, 0);
            <c:forEach var="moon" items="${planet.moons}">
                ${moon.name} = loadTexturedPlanet(${moon.name}Data, ${moon.name}Data.distanceFromAxis,0,0);
                ${moon.name}Orbit = getTube(${moon.orbitSize}, ${moon.innerSize}, ${moon.faceRoundness}, ${moon.faceDigRound}, ${moon.color}, "ring${moon.name}", ${moon.planetName}Data.distanceFromAxis);
            </c:forEach>
        </c:forEach>

        /*
        moonOrbit = getTube(2.8, 0.01, 480, 480, 0x757064, "ringMoon", earthData.distanceFromAxis);
        saturnRing = getTube(11.3, 2, 2, 480, 0x8D7E60, "jupiterRing", jupiterData.distanceFromAxis);*/

        var spriteMaterial = new THREE.SpriteMaterial({
            map: new THREE.TextureLoader().load('./resources/texture/glow.png'),
            useScreenCoordinates: false,
            color: 0xF6891F,
            transparent: false,
            blending: THREE.AdditiveBlending
        });
        var sprite = new THREE.Sprite(spriteMaterial);
        sprite.scale.set(200, 200, 1.0);
        <c:forEach var="planet" items="${planets}">
            <c:if test="${planet.type=='Sol'}">
                ${planet.name}.add(sprite);
            </c:if>
        </c:forEach>

        // Create the visible orbit that the Earth uses.
        createVisibleOrbits();

        // add a resize to the canvas
        window.addEventListener('resize', onWindowResize, false);

        function onWindowResize() {

            camera.aspect = $('#webgl').innerWidth() / $('#webgl').innerHeight();
            camera.updateProjectionMatrix();

            renderer.setSize(window.innerWidth, window.innerHeight);

        }

        // Start the animation.
        update(renderer, scene, camera, controls);
    }

    function movePlanets() {
        var time = Date.now();

        <c:forEach var="planet" items="${planets}">
        movePlanet(${planet.name}, ${planet.name}Data, time);
            <c:forEach var="moon" items="${planet.moons}">
                movePlanet(${moon.name}Orbit, ${moon.planetName}Data, time, true);
                moveMoon(${moon.name},${moon.planetName},${moon.name}Data,time);
            </c:forEach>
        </c:forEach>
        renderer.render(scene, camera);
    }

    /**
     * This function is called in a loop to create animation.
     * @param {type} renderer
     * @param {type} scene
     * @param {type} camera
     * @param {type} controls
     * @returns {undefined}
     */
    var cameraTarget;

    function update(renderer, scene, camera, controls) {
        <c:forEach var="planet" items="${planets}">
            <c:if test="${planet.type=='Sol'}">
                pointLight.position.copy(${planet.name}.position);
            </c:if>
        </c:forEach>

        movePlanets();

        if (intersects != null && intersects.length > 0) {
            cameraTarget = scene.getObjectByName(intersects);

            controls.target.set(cameraTarget.position.x - 2, cameraTarget.position.y - 2, cameraTarget.position.z - 2);

            camera.lookAt(cameraTarget.position);

            // intersects = null;
        }

        controls.update();
        requestAnimationFrame(function () {
            update(renderer, scene, camera, controls);
        });
    }

    // Start everything.
    init();

    var openPlanetInformation = false;
    var planetInformation;
    $("#webgl").click(function (e) {
        e.preventDefault();

        mouse.x = (e.offsetX / $("#webgl").innerWidth()) * 2 - 1;
        mouse.y = -(e.offsetY / $("#webgl").innerHeight()) * 2 + 1;

        raycaster.setFromCamera(mouse, camera);
        intersects = raycaster.intersectObjects(scene.children);
        if (intersects.length > 0) {
            intersects = intersects[0].object.name;
        }else{
            intersects = null;
        }

        if(intersects != null){
            $('#'+planetInformation).removeClass('show');
            $('#'+planetInformation).addClass('hide');
            $('#'+intersects).removeClass('hide');
            $('#'+intersects).addClass('show');
            planetInformation = intersects;
        }
    });

    function setPlanetIntersects(planetName){
        intersects = planetName;
        setPlanetInformation();
    }
</script>

<%@include file="layout/fotter.jsp"%>
