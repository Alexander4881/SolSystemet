var pointLight, controls, scene, camera, renderer;
var planetSegments = 48;
var saturn, uranus, neptune;

var sun;
var sunData = constructPlanetData(1,0.001,0,"sun","texture/sun.jpg",50,planetSegments);

var mercury, mercuryOrbit;
var mercuryData = constructPlanetData(80, 0.0015,57,"mercury","texture/mercury.jpg",0.38,planetSegments);

var venus, venusOrbit;
var venusData = constructPlanetData(225, -0.015, 65, "venus", "texture/venus.jpg", 1, planetSegments)

var earth, earthOrbit;
var earthData = constructPlanetData(365.2564, 0.024, 80, "earth", "texture/earth.jpg", 1, planetSegments);

var moon;
var moonData = constructPlanetData(27, 0.02, 2.8, "moon", "texture/moon.jpg", 0.5, planetSegments);
var moonOrbit;

var mars, marsOrbit;
var marsData = constructPlanetData(687, 0.015, 90, "mars", "texture/mars.jpg", 0.5, planetSegments);

var jupiter, jupiterOrbit;
var jupiterData = constructPlanetData(4380, 0.015, 110, "jupiter", "texture/jupiter.jpg", 8, planetSegments);

var saturn, saturnOrbit;
var saturnData = constructPlanetData(  10585, 0.005, 135, "saturn", "texture/saturn.jpg", 8, planetSegments);
var saturnRing;

var uranus, uranusOrbit;
var uranusData = constructPlanetData( 30660, 0.015, 152, "uranus", "texture/uranus.jpg", 3, planetSegments);

var neptune, neptuneOrbit;
var neptuneData = constructPlanetData(60225, 0.015, 160, "neptune", "texture/neptune.jpg", 3, planetSegments);

var pluto, plutoOrbit;
var plutoData = constructPlanetData(90520, 0.015, 170, "pluto", "texture/pluto.jpg", 0.2, planetSegments);

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
    earthOrbit = getRing(earthData.distanceFromAxis + orbitWidth, earthData.distanceFromAxis - orbitWidth, 320, 0xffffff, "earthOrbit", 0);
    mercuryOrbit = getRing(mercuryData.distanceFromAxis + orbitWidth, mercuryData.distanceFromAxis - orbitWidth, 320, 0xffffff, "mercuryOrbit", 0);
    venusOrbit = getRing(venusData.distanceFromAxis + orbitWidth, venusData.distanceFromAxis - orbitWidth, 320, 0xffffff, "venusOrbit", 0);
    marsOrbit = getRing(marsData.distanceFromAxis + orbitWidth, marsData.distanceFromAxis - orbitWidth, 320, 0xffffff, "venusOrbit", 0);
    jupiterOrbit = getRing(jupiterData.distanceFromAxis + orbitWidth, jupiterData.distanceFromAxis - orbitWidth, 320, 0xffffff, "jupiterOrbit", 0);
    saturnOrbit = getRing(saturnData.distanceFromAxis + orbitWidth, saturnData.distanceFromAxis - orbitWidth, 320, 0xffffff, "saturnOrbit", 0);
    uranusOrbit = getRing(uranusData.distanceFromAxis + orbitWidth, uranusData.distanceFromAxis - orbitWidth, 320, 0xffffff, "uranusOrbit", 0);
    neptuneOrbit = getRing(neptuneData.distanceFromAxis + orbitWidth, neptuneData.distanceFromAxis - orbitWidth, 320, 0xffffff, "neptuneOrbit", 0);
    plutoOrbit = getRing(plutoData.distanceFromAxis + orbitWidth, plutoData.distanceFromAxis - orbitWidth, 320, 0xffffff, "plutoOrbit", 0);
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
        passThisTexture = new THREE.ImageUtils.loadTexture(myData.texture);
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
 * This function is called in a loop to create animation.
 * @param {type} renderer
 * @param {type} scene
 * @param {type} camera
 * @param {type} controls
 * @returns {undefined}
 */
function update(renderer, scene, camera, controls) {
    pointLight.position.copy(sun.position);
    controls.update();

    var time = Date.now();

    movePlanet(sun, sunData, time);
    movePlanet(mercury, mercuryData, time);
    movePlanet(venus, venusData, time);
    movePlanet(earth, earthData, time);
    movePlanet(moonOrbit, earthData, time, true);
    moveMoon(moon, earth, moonData, time);
    movePlanet(mars, marsData, time);
    movePlanet(jupiter, jupiterData,time);
    movePlanet(saturn, saturnData, time);
    movePlanet(saturnRing, saturnData, time, true);
    movePlanet(uranus, uranusData, time);
    movePlanet(neptune, neptuneData, time);
    movePlanet(pluto, plutoData,time);
    renderer.render(scene, camera);
    requestAnimationFrame(function () {
        update(renderer, scene, camera, controls);
    });
}

/**
 * This is the function that starts everything.
 * @returns {THREE.Scene|scene}
 */
function init() {
    // Create the camera that allows us to view into the scene.
    camera = new THREE.PerspectiveCamera(
        45, // field of view
        window.innerWidth / window.innerHeight, // aspect ratio
        1, // near clipping plane
        1000 // far clipping plane
    );
    camera.position.z = 60;
    camera.position.x = -150;
    camera.position.y = 30;
    camera.lookAt(new THREE.Vector3(0, 0, 0));

    // Create the scene that holds all of the visible objects.
    scene = new THREE.Scene();

    // Create the renderer that controls animation.
    renderer = new THREE.WebGLRenderer();
    renderer.setSize(window.innerWidth, window.innerHeight);

    // Attach the renderer to the div element.
    document.getElementById('webgl').appendChild(renderer.domElement);

    // Create controls that allows a user to move the scene with a mouse.
    controls = new THREE.OrbitControls(camera, renderer.domElement);

    // Load the images used in the background.
    var path = 'cubemap/';
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

    // Create the Earth, the Moon, and a ring around the earth.
    sun = loadTexturedPlanet(sunData, sunData.distanceFromAxis, 0,0);
    
    mercury = loadTexturedPlanet(mercuryData, mercuryData.distanceFromAxis,0,0);

    venus = loadTexturedPlanet(venusData, venusData.distanceFromAxis,0,0);

    earth = loadTexturedPlanet(earthData, earthData.distanceFromAxis, 0, 0);
    moon = loadTexturedPlanet(moonData, moonData.distanceFromAxis, 0, 0);
    moonOrbit = getTube(2.8, 0.01, 480,480, 0x757064, "ringMoon", earthData.distanceFromAxis);

    mars = loadTexturedPlanet(marsData, marsData.distanceFromAxis,0,0);

    jupiter = loadTexturedPlanet(jupiterData,jupiterData.distanceFromAxis,0,0);

    saturn = loadTexturedPlanet(saturnData, saturnData.distanceFromAxis,0,0);
    saturnRing = getTube( 11.3, 2, 2,480, 0x8D7E60, "jupiterRing", jupiterData.distanceFromAxis);

    uranus = loadTexturedPlanet(uranusData, uranusData.distanceFromAxis, 0, 0);

    neptune = loadTexturedPlanet(neptuneData, neptuneData.distanceFromAxis, 0,0);

    pluto = loadTexturedPlanet(plutoData, plutoData .distanceFromAxis,0,0);

    // Create the visible orbit that the Earth uses.
    createVisibleOrbits();

    // Start the animation.
    update(renderer, scene, camera, controls);
}

// Start everything.
init();