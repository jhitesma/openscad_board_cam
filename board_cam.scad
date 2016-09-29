board_w = 32;
board_d = 32;
board_h = 1.5;

cam_w = 17;
cam_d = 17;
cam_h = 7.5;

hole_offset = 2.6;

$fn=50;

board_cam(board_w,board_d,board_h,cam_w,cam_d,cam_h);

module board_cam(board_w,board_d,board_h,cam_w,cam_d,cam_h) {
    translate([-board_w/2,-board_d/2,0])
    difference () {
        union () {
            // board
            cube ([board_w,board_d,board_h]);
            //cam_body
            union() {
                translate([(board_w-cam_w)/2,(board_d-cam_d)/2,board_h]) cube([cam_w,cam_d,cam_h]);
                translate([board_w/2,board_d/2,board_h+cam_h+(5.5/2)]) cylinder (h=5.5, d=15.5,center=true);
                translate([(board_w-cam_w)/2-1,board_d/2,cam_h/2+board_h]) cylinder(h=cam_h, d=5, center=true, $fn=50);
                translate([(board_w-cam_w)/2+1+cam_w,board_d/2,cam_h/2+board_h]) cylinder(h=cam_h, d=5, center=true, $fn=50);
                translate([(board_w-cam_w)/2-1.25,board_d/2-2.5,board_h]) cube([cam_w+2.5,5,cam_h]);
            }
        
            // lock ring
            translate([board_w/2,board_d/2,board_h+cam_h+5.5]) lock_ring(15.5,2.5,2);
            // lens_shaft
            translate([board_w/2,board_d/2,board_h+cam_h+5.5+2.5+(3/2)]) cylinder (h=3, d=11.83,center=true);
            // lens body
            union() {
                difference() {
                    translate([board_w/2,board_d/2,board_h+cam_h+5.5+2.5+3+(3.6/2)]) cylinder (h=3.6, d=14,center=true);
                    translate([board_w/2,board_d/2,board_h+cam_h+5.5+2.5+3+(3.6/2)+5]) sphere (d=14,center=true);        
                }
                difference() {
                    translate([board_w/2,board_d/2,board_h+cam_h+5.5+2.5+3+(3.6/2)-5.1]) sphere (d=14,center=true);        
                    translate([board_w/2,board_d/2,board_h+cam_h+1.5]) cube ([20,20,20], center=true);        
                }
            }
        }
        translate([hole_offset,hole_offset,2]) cylinder(d=3,h=5, center=true, $fn=50);
        translate([board_w-hole_offset,hole_offset,2]) cylinder(d=3,h=5, center=true, $fn=50);
        translate([hole_offset,board_d-hole_offset,2]) cylinder(d=3,h=5, center=true, $fn=50);
        translate([board_w-hole_offset,board_d-hole_offset,2]) cylinder(d=3,h=5, center=true, $fn=50);
    }
}

module lock_ring(d,h,o) { 
    difference() {
        translate([0,0,h/2]) cylinder (h=h, d=d,center=true);
        translate([0,7.75,h/2]) cube ([16,1,3], true);
        translate([0,-7.75,h/2]) cube ([16,1,3], true);
        for (i = [15:15:90]) {
            rotate (a=i, v=[0,0,1]) knurls(d,h,o);
        }
    }
}
            
module knurls(d,h,o) {
    for (i = [
            [d/2-o, d/2-o, h/2],
            [-d/2+o, -d/2+o, h/2],
            [d/2-o, -d/2+o, h/2],
            [-d/2+o, d/2-o, h/2]
        ]) {
            translate(i) cylinder(h=3, d=1.5, center=true);
        }
}