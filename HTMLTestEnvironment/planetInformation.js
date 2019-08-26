var scene = new THREE.Scene();
var camera = new THREE.PerspectiveCamera(75, $('#webgl').innerWidth() / $('#webgl').innerHeight(), 0.1, 1000);

var renderer = new THREE.WebGLRenderer();
var cube;


function setUp() {

    var spotLight = new THREE.SpotLight(0xffffff);
    spotLight.position.set(200, 400, 300);
    scene.add(spotLight);

    renderer.setSize($('#webgl').innerWidth(), $('#webgl').innerHeight());
    document.getElementById('webgl').appendChild(renderer.domElement);
    
    var geometry = new THREE.SphereGeometry(3, 80, 80);
    //var geometry = new THREE.SphereGeometry( 5, 32, 32 );

    var texture = new THREE.TextureLoader().load("./texture/earth-night.jpg");
    var color = "rgb(255,255,255)";
    var material = new THREE.MeshLambertMaterial({ color: color, map: texture })
    cube = new THREE.Mesh(geometry, material);
    scene.add(cube);
    camera.position.z = 5;

    // add a resize to the canvas
    window.addEventListener('resize', onWindowResize, false);
    function onWindowResize() {

        camera.aspect = $('#webgl').innerWidth() / $('#webgl').innerHeight();
        camera.updateProjectionMatrix();
        renderer.setSize($('#webgl').innerWidth() / $('#webgl').innerHeight());
    }
}

var animate = function () {
    requestAnimationFrame(animate);

    cube.rotation.x += 0.001;
    cube.rotation.y += 0.001;

    renderer.render(scene, camera);
};

setUp();
animate();