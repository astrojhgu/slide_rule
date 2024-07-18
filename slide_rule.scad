$fn = 30;

body_thickness = 7;
rule_thickness = 4;
label_thickness = 2;
rule_width = 20;
body_label_width = 15;
length = 300;
window_claw_h = 3;
window_claw_w = 2;
key_len = 2;
key_width = 2;
tol = 0.1;
window_height = body_thickness + key_len + 5;
window_width = body_label_width * 2 + key_len * 2 + rule_width + 5;
window_length = 30;
transparent_window_width = body_label_width * 2 + rule_width;
transparent_window_len = window_length - 4;
transparent_window_thickness = 3;
transparent_window_width1 = body_label_width * 2 + rule_width - 5;
transparent_window_len1 = window_length - 4 - 4;
screw_hole_end_sep = 10;

module body()
{
	difference()
	{
		rotate([ 90, 0, 0 ])
		translate([ 0, 0, -length / 2 ])
		{
			linear_extrude(length)
			{
				polygon(points = [

					[ rule_width / 2 + key_len + tol, body_thickness - rule_thickness ],
					[ rule_width / 2 + key_len + tol, body_thickness - rule_thickness + key_width + tol ],        // 7
					[ rule_width / 2 + tol, body_thickness - rule_thickness + key_width + tol ],                  // 6
					[ rule_width / 2 + tol, body_thickness ],                                                     // 5
					[ rule_width / 2 + body_label_width, body_thickness ],                                        // 4
					[ rule_width / 2 + body_label_width, body_thickness + label_thickness ],                      // 3
					[ rule_width / 2 + body_label_width + key_width, body_thickness + label_thickness ],          // 2
					[ rule_width / 2 + body_label_width + key_width, window_claw_h + tol ],                       // 1
					[ rule_width / 2 + body_label_width + key_width - window_claw_w - tol, window_claw_h + tol ], // 1
					[ rule_width / 2 + body_label_width + key_width - window_claw_w - tol, 0 ],                   // 1

					[ -rule_width / 2 - body_label_width - key_width + window_claw_w + tol, 0 ],                   // 1
					[ -rule_width / 2 - body_label_width - key_width + window_claw_w + tol, window_claw_h + tol ], // 1
					[ -rule_width / 2 - body_label_width - key_width, window_claw_h + tol ],                       // 1
					[ -rule_width / 2 - body_label_width - key_width, body_thickness + label_thickness ],          // 2
					[ -rule_width / 2 - body_label_width, body_thickness + label_thickness ],                      // 3
					[ -rule_width / 2 - body_label_width, body_thickness ],                                        // 4
					[ -rule_width / 2 - tol, body_thickness ],                                                     // 5
					[ -rule_width / 2 - tol, body_thickness - rule_thickness + key_width + tol ],                  // 6
					[ -rule_width / 2 - tol - key_len, body_thickness - rule_thickness + key_width + tol ],        // 7
					[ -rule_width / 2 - tol - key_len, body_thickness - rule_thickness ],                          // 8
				]);
			}
		}
		for (x = [ rule_width/2+body_label_width/2, -rule_width/2-body_label_width/2 ])
		{
			translate([ x, length / 2 - screw_hole_end_sep, 0 ])
			cylinder(h = body_thickness + tol, d = 2.5);
			translate([ x, -(length / 2 - screw_hole_end_sep), 0 ])
			cylinder(h = body_thickness + tol, d = 2.5);
			translate([ x, 0, 0 ])
			cylinder(h = body_thickness + tol, d = 2.5);
		}
	}

	translate([rule_width/2+tol,length/2-label_thickness,body_thickness])
	cube([body_label_width,key_width, label_thickness]);

	translate([-rule_width/2-body_label_width-tol,length/2-label_thickness,body_thickness])
	cube([body_label_width,key_width, label_thickness]);

	translate([rule_width/2+tol,-length/2-label_thickness+key_width,body_thickness])
	cube([body_label_width,key_width, label_thickness]);

	translate([-rule_width/2-body_label_width-tol,-length/2-label_thickness+key_width,body_thickness])
	cube([body_label_width,key_width, label_thickness]);
}

module rule()
{
	difference()
	{
		rotate([ 90, 0, 0 ])
		translate([ 0, 0, -length / 2 ])
		{

			linear_extrude(length)
			{
				polygon(points = [
					[ 0, body_thickness ], [ rule_width / 2, body_thickness ],                    // 4
					[ rule_width / 2, body_thickness - rule_thickness + key_width ],              // 3
					[ rule_width / 2 + key_len, body_thickness - rule_thickness + key_width ],    // 2
					[ rule_width / 2 + key_len, body_thickness - rule_thickness ],                // 1
					[ -(rule_width / 2 + key_len), body_thickness - rule_thickness ],             // 1
					[ -(rule_width / 2 + key_len), body_thickness - rule_thickness + key_width ], // 2
					[ -(rule_width / 2), body_thickness - rule_thickness + key_width ],           // 3
					[ -rule_width / 2, body_thickness ],                                          // 4
				]);
			}
		}
		translate([ 0, length / 2 - screw_hole_end_sep, 0 ])
		cylinder(h = body_thickness + tol, d = 2.5);
		translate([ 0, -(length / 2 - screw_hole_end_sep), 0 ])
		cylinder(h = body_thickness + tol, d = 2.5);
		translate([ 0, 0, 0 ])
		cylinder(h = body_thickness + tol, d = 2.5);
	}
	translate([-rule_width/2,length/2-key_width, body_thickness])
	#cube([rule_width,key_width, label_thickness]);

	translate([-rule_width/2,-length/2, body_thickness])
	cube([rule_width,key_width, label_thickness]);
}

module window()
{
	rotate([ 90, 0, 0 ])
	difference()
	{
		translate([ 0, 0, -window_length / 2 ])
		{
			linear_extrude(window_length)
			{
				polygon(points = [
					//[0,body_thickness+key_len+tol],
					[ rule_width / 2 + body_label_width + key_width + tol, body_thickness + key_len + tol ],      // 6
					[ rule_width / 2 + body_label_width + key_width + tol, window_claw_h - tol ],                 // 5
					[ rule_width / 2 + body_label_width + key_width - window_claw_w + tol, window_claw_h - tol ], // 4
					[ rule_width / 2 + body_label_width + key_width - window_claw_w + tol, tol ],                 // 3
					[ window_width / 2, tol ],                                                                    // 2
					[ window_width / 2, window_height ],                                                          // 1
					[ -window_width / 2, window_height ],                                                         // 1
					[ -window_width / 2, tol ],                                                                   // 2
					[ -rule_width / 2 - body_label_width - key_width + window_claw_w - tol, tol ],                // 3
					[
						-(rule_width / 2 + body_label_width + key_width - window_claw_w + tol), window_claw_h - tol
					],                                                                                          // 4
					[ -(rule_width / 2 + body_label_width + key_width + tol), window_claw_h - tol ],            // 5
					[ -(rule_width / 2 + body_label_width + key_width + tol), body_thickness + key_len + tol ], // 6
				]);
			}
		}
		translate([ 0, body_thickness + key_len ])
		union()
		{
			translate([ 0, transparent_window_thickness / 2, 0 ])
			cube(size = [ transparent_window_width, transparent_window_thickness, transparent_window_len ],
			     center = true);
			translate([ -transparent_window_width1 / 2, 0, -transparent_window_len1 / 2 ])
			cube(size = [ transparent_window_width1, 100, transparent_window_len1 ]);
		}
	}
}

body();
rule();
window();
