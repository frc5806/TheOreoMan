res=100;

thickness = 0.25;

module tube(height) {
    color([1,1,1]) linear_extrude(height) difference() {
        circle(1, $fn=res);
        circle(0.9375, $fn=res);
    }
}

module knotches(num) {
    for (i = [-0.375 : 0.5 : -0.375+0.5*(num-1)]) {
        translate([i,1.125]) square([0.25,thickness]);
        translate([i,-1.375]) square([0.25,thickness]);
    }
}


module top_plate() {
    difference() {
        union() {
            translate([0,-1.5,0]) square([1.5,3]);
            circle(1.5, $fn=res);
        } translate([0,0,0]) circle(1, $fn=res); 
        knotches(4);
    }
}

angle = 20;

module tray_plate() {
    tray = 2;

     difference() {
        union() {
            translate([0,-1.5,0]) square([1.5+tray,3]);
            scale([1/cos(angle),1]) circle(1.5, $fn=res);
        } knotches(8);
    }
}

module side_plate() {
        difference() {
            square([3.87,2]);
            translate([0,0.55]) rotate(20) square([5,2]);
            translate([3,-1.73]) rotate(40) square([6,2]);
            translate([3.75,1.62]) square([0.125,0.25]);
        } 
        
        for (i = [0.125 : 0.5 : 1.625]) {
            translate([i,-.25]) square([0.25,0.25]);
        }
        
        for (i = [0 : 0.5 : 3.5]) {
            rotate(angle) translate([0.435+i,0.5]) square([0.25,0.27]);
        }
}

module oreo_blocker() {
    square([2.75,0.125]);
}

module render_3d() {
    tube(25);

    color([1,0,0]) linear_extrude(thickness) top_plate();

    translate([0,0,-1]) rotate([0,angle,0]) linear_extrude(thickness) tray_plate();

    color([0,1,1]) translate([-0.5,-1.375,0]) rotate([90,180,180]) linear_extrude(thickness) side_plate();

    color([0,1,1]) translate([-0.5,1.125,0]) rotate([90,180,180]) linear_extrude(thickness) side_plate();
    
    color([1,0,1]) translate([3.38,-1.375,-1.87]) rotate([0,0,90]) linear_extrude(thickness) oreo_blocker();
}

module laser_layout() {
    translate([1.6,1.6]) top_plate();
    translate([1.6,6.7]) rotate(-90) tray_plate();
    translate([0.1,9.3]) rotate(-20) side_plate();
    translate([3.8,9.2]) rotate(250) side_plate();
    translate([3.5,3]) rotate(90) oreo_blocker();

}

//render_3d();
laser_layout();

