({
	setup : function(component, event, helper) {        
        alert('loaded');
        var container;    
        var camera, controls, scene, renderer;
        var mouseX = 0, mouseY = 0;
        var windowHalfX = 1000 / 2;
        var windowHalfY = 700 / 2;

        container = document.createElement( 'div' );
        document.body.appendChild( container );
        camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 2000 );
        camera.position.z = 100;

        scene = new THREE.Scene();

        var ambientLight = new THREE.AmbientLight( 0xd3d3d3, 0.4 );
        scene.add( ambientLight );

        var pointLight = new THREE.PointLight( 0xd3d3d3, 0.6 );
        camera.add( pointLight );
        scene.add( camera );

        var onProgress = function ( xhr ) {
            if ( xhr.lengthComputable ) {
                var percentComplete = xhr.loaded / xhr.total * 100;
                console.log( Math.round(percentComplete, 2) + '% downloaded' );
            }
        };
        // model
        var onError = function ( xhr ) {
        };
        var mesh = new THREE.Mesh( new THREE.PlaneBufferGeometry( 2000, 2000 ), new THREE.MeshPhongMaterial( { color: 0x999999, depthWrite: false } ) );
        mesh.rotation.x = - Math.PI / 2;
        mesh.receiveShadow = true;
        scene.add( mesh );

        var loader = new THREE.FBXLoader();
        //loader.load( 'https://rjeet-dev-ed--c.ap5.visual.force.com/resource/1573646962000/threed', function ( object ) {

        loader.load( "{!URLFOR($Resource.threed)}", function ( object ) {
            object.traverse( function ( child ) {
                if ( child instanceof THREE.Mesh ) {
                    //child.material.map = texture;
                }
            } );
            object.scale.set(1,1,1);
            object.position.y = 0;
            object.position.z = 0;
            object.position.x = 0;
            scene.add( object );                

        }, onProgress, onError );
        //alert('init 4');
        renderer = new THREE.WebGLRenderer({            
            alpha: true
        });
        //controls = new THREE.OrbitControls( camera );
        //controls.addEventListener( 'change', render );
        renderer.setPixelRatio( window.devicePixelRatio );
        renderer.setSize( window.innerWidth, window.innerHeight );
        renderer.shadowMap.enabled = true;
        container.appendChild( renderer.domElement );

        //window.addEventListener( 'resize', onWindowResize, false );

        //alert('hi');


        function onWindowResize() {
            windowHalfX = 1000 / 2;
            windowHalfY = 700 / 2;
            camera.aspect = 1000 / 700;
            camera.updateProjectionMatrix();
            renderer.setSize( 1000, 700 );
        }
        function render() {

            renderer.render( scene, camera );
        }
        function animate() {                
            requestAnimationFrame( animate );                
            var delta = clock.getDelta();                
            if ( mixer ) mixer.update( delta );
            renderer.render( scene, camera );
            stats.update();

        }
        //stats.update();
    }
})