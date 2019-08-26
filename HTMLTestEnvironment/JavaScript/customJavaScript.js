'use strict';

/* global THREE */

var earth;
const scene = new THREE.Scene();
var tween;
var temp = false;
var curveSeaRoute;


function main() {
  const canvas = document.querySelector('#c');
  const renderer = new THREE.WebGLRenderer({canvas});

  const fov = 45;
  const aspect = 2;  // the canvas default
  const near = 0.1;
  const far = 300;
  const camera = new THREE.PerspectiveCamera(fov, aspect, near, far);
  camera.position.set(0, 10, 150);

  const controls = new THREE.OrbitControls(camera, canvas);
  controls.target.set(0, 5, 0);
  controls.update();

  scene.background = new THREE.Color('black');

  // {
  //   const planeSize = 40;

  //   const loader = new THREE.TextureLoader();
  //   const texture = loader.load('../CSS/Objects/checker.png');
  //   texture.wrapS = THREE.RepeatWrapping;
  //   texture.wrapT = THREE.RepeatWrapping;
  //   texture.magFilter = THREE.NearestFilter;
  //   const repeats = planeSize / 2;
  //   texture.repeat.set(repeats, repeats);

  //   const planeGeo = new THREE.PlaneBufferGeometry(planeSize, planeSize);
  //   const planeMat = new THREE.MeshPhongMaterial({
  //     map: texture,
  //     side: THREE.DoubleSide,
  //   });
  //   const mesh = new THREE.Mesh(planeGeo, planeMat);
  //   mesh.rotation.x = Math.PI * -.5;
  //   scene.add(mesh);
  // }

  {
    const skyColor = 0xB1E1FF;  // light blue
    const groundColor = 0xB97A20;  // brownish orange
    const intensity = 1;
    const light = new THREE.HemisphereLight(skyColor, groundColor, intensity);
    scene.add(light);
  }

  {
    const color = 0xFFFFFF;
    const intensity = 1;
    const light = new THREE.DirectionalLight(color, intensity);
    light.position.set(5, 10, 2);
    scene.add(light);
    scene.add(light.target);
  }

  {
    const gltfLoader = new THREE.GLTFLoader();
    gltfLoader.load('../CSS/3DObjects/Solarsystemv2.gltf', (gltf) => {
      const root = gltf.scene;
      earth = root;
      scene.add(root);
    });

    // const objLoader = new THREE.OBJLoader2();
    // objLoader.loadMtl('../CSS/3D_Objects/test-earth.mtl', null, (materials) => {
    //   // materials.Material.side = THREE.DoubleSide;
    //   objLoader.setMaterials(materials);
    //   objLoader.load('../CSS/3D_Objects/test-earth.obj', (event) => {
    //     const root = event.detail.loaderRootNode;
    //     earth = root;
    //     scene.add(earth);
    //   });
    // });


    curveSeaRoute = new THREE.CatmullRomCurve3([new THREE.Vector3(18, roadHeight, 31), new THREE.Vector3(24, roadHeight, 23), new THREE.Vector3(22, roadHeight, 20), new THREE.Vector3(14, roadHeight, 19), new THREE.Vector3(10, roadHeight, 20), new THREE.Vector3(8, roadHeight, 23), new THREE.Vector3(10, roadHeight, 31)]);
  }
  
  function resizeRendererToDisplaySize(renderer) {
    const canvas = renderer.domElement;
    const width = canvas.clientWidth;
    const height = canvas.clientHeight;
    const needResize = canvas.width !== width || canvas.height !== height;
    if (needResize) {
      renderer.setSize(width, height, false);
    }
    return needResize;
  }







  var t = 0;
  function render(time) {

    if (resizeRendererToDisplaySize(renderer)) {
      const canvas = renderer.domElement;
      
      
      camera.aspect = canvas.clientWidth / canvas.clientHeight;
      camera.updateProjectionMatrix();
    }


    if(temp){
        tween = new TWEEN.Tween(scene.children[4].children[0].material[0].color)
            .to({r: 0, g: 25, b: 155}, 2000)
            .easing(TWEEN.Easing.Quartic.In)
            .start();
        temp=false;
        console.log("start color animation");
      }

      if(tween) tween.update(time);

    renderer.render(scene, camera);

    requestAnimationFrame(render);

  }

  requestAnimationFrame(render);
}

main();




var onKeyDown = function(event) {
  if (event.keyCode == 67) { // when 'c' is pressed
    temp = true;
    console.log(scene.children[4].children[0].material[0].color);

  }
};
document.addEventListener('keydown', onKeyDown, false);
