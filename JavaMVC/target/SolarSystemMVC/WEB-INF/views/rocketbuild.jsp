<%--
  Created by IntelliJ IDEA.
  User: alihn
  Date: 29-08-2019
  Time: 17:58
  To change this template use File | Settings | File Templates.
--%>
<link rel="./resources/css/customCSS.css" />

<table class="w-100 h-100">

    <thead>
        <th class="w-5"></th>
        <th class="w-90"></th>
        <th class="w-5"></th>
    </thead>
    <tbody>
        <tr class="h-10">
            <td colspan="3">3 span</td>
        </tr>

        <tr class="h-25">
            <td> <button type="button" class="btn btn-dark"><</button> </td>
            <td rowspan="3">test</td>
            <td> <button type="button" class="btn btn-dark">></button> </td>
        </tr>

        <tr class="h-25">
            <td> <button type="button" class="btn btn-dark"><</button> </td>
            <td> <button type="button" class="btn btn-dark">></button> </td>
        </tr>

        <tr class="h-25">
            <td> <button type="button" class="btn btn-dark"><</button> </td>
            <td> <button type="button" class="btn btn-dark">></button> </td>
        </tr>
    </tbody>
</table>

<%@include file="layout/header.jsp"%>

<script src="<c:url value="/resources/javascript/three.js"/>"></script>
<script>
    //import * as THREE from "/resources/javascript/three.js";

    let scene = new THREE.Scene();
    let camera = new THREE.PerspectiveCamera(75, $("#webgl").innerWidth() / $("#webgl").innerHeight(), 0.1, 1000);

    var renderer = new THREE.WebGLRenderer();
    renderer.setSize( $("#webgl").innerWidth(), $("#webgl").innerHeight() );
    $("#webgl").append( renderer.domElement );


    let geometry = new THREE.BoxGeometry( 1, 1, 1 );
    let material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
    let cube = new THREE.Mesh( geometry, material );
    scene.add( cube );

    camera.position.z = 5;

    function animate() {
        requestAnimationFrame( animate );

        cube.rotation.x += 0.01;
        cube.rotation.y += 0.01;

        renderer.render( scene, camera );
    }
    animate();

</script>

<%@include file="layout/fotter.jsp"%>
