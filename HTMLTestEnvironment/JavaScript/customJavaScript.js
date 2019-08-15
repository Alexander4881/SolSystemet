console.log("test link to JavaScript");

var scene = new THREE.Scene();
// add a canvas to the document but to the container fluid class

var fluidContaner = $(".container-fluid")[0];

var camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );
var renderer = new THREE.WebGLRenderer();
// set the renderer size
renderer.setSize( $(fluidContaner).innerWidth()-17, $(fluidContaner).innerHeight() );
fluidContaner.appendChild(renderer.domElement)

var geometry = new THREE.BoxGeometry( 1, 1, 1 );
var material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
var cube = new THREE.Mesh( geometry, material );
scene.add( cube );

camera.position.z = 5;

// our render animation
function animate() {
    requestAnimationFrame( animate );

    cube.rotation.x += 0.01;
    cube.rotation.y += 0.01;

    renderer.render( scene, camera );
}
animate();