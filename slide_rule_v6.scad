$fn = 30;

body_thickness = 5;
rule_thickness = body_thickness;
label_thickness = 2;
rule_width = 20;
body_label_width = 15;
length = 300;

key_len = 2;
key_width = 2;
tol = 0.1;
window_height = body_thickness + key_len + 7.5;
window_width = body_label_width * 2 + key_width * 2 + rule_width + 18;
window_length = 30;
transparent_window_width = body_label_width * 2 + rule_width;
transparent_window_len = window_length - 4;
transparent_window_thickness = 2;
transparent_window_width1 = body_label_width * 2 + rule_width - 5;
transparent_window_len1 = window_length - 4 - 4;
screw_hole_end_sep = 10;

connector_dy = 10;
connector_dx = body_label_width * 2 + key_width * 2 + rule_width;

hair_d = 1.6;

module body()
{

    difference()
    {
        union()
        {
            rotate([ 90, 0, 0 ]) translate([ 0, 0, -length / 2 ])
            {
                linear_extrude(length)
                {
                    polygon(points = [
                        [ -body_label_width - rule_width / 2 - key_width, body_thickness / 2 + label_thickness ],  // 6
                        [ -body_label_width - rule_width / 2, body_thickness / 2 + label_thickness ],              // 5
                        [ -body_label_width - rule_width / 2, body_thickness / 2 ],                                // 4
                        [ -rule_width / 2, body_thickness / 2 ],                                                   // 3
                        [ -rule_width / 2, key_width / 2 ],                                                        // 2
                        [ -rule_width / 2 - key_len, key_width / 2 ],                                              // 1
                        [ -rule_width / 2 - key_len, -key_width / 2 ],                                             // 1
                        [ -rule_width / 2, -key_width / 2 ],                                                       // 2
                        [ -rule_width / 2, -body_thickness / 2 ],                                                  // 3
                        [ -body_label_width - rule_width / 2, -body_thickness / 2 ],                               // 4
                        [ -body_label_width - rule_width / 2, -body_thickness / 2 - label_thickness ],             // 5
                        [ -body_label_width - rule_width / 2 - key_width, -body_thickness / 2 - label_thickness ], // 6
                    ]);
                }
            }

            translate([ 0, length / 2 - connector_dy / 2, 0 ]) body_connector();

            translate([ 0, -length / 2 + connector_dy / 2, 0 ]) body_connector();
        }

        translate([ -rule_width / 2 - body_label_width / 2, length / 2 - connector_dy / 2, 0 ])
            cylinder(d = 2.5, h = 50, center = true);

        translate([ -rule_width / 2 - body_label_width / 2, -length / 2 + connector_dy / 2, 0 ])
            cylinder(d = 2.5, h = 50, center = true);

        translate([ rule_width / 2 + body_label_width / 2, length / 2 - connector_dy / 2, 0 ])
            cylinder(d = 3.2, h = 50, center = true);

        translate([ rule_width / 2 + body_label_width / 2, -length / 2 + connector_dy / 2, 0 ])
            cylinder(d = 3.2, h = 50, center = true);

        translate([ rule_width / 2 + body_label_width / 2, length / 2 - connector_dy / 2, body_thickness / 2 + 3 ])
            cylinder(d = 7.5, h = 50);

        translate([ rule_width / 2 + body_label_width / 2, -length / 2 + connector_dy / 2, body_thickness / 2 + 3 ])
            cylinder(d = 7.5, h = 50);

        n = 19;
        d = (length - connector_dy * 3) / n / 2;
        for (i = [-n:2:n])
        {
            translate([ -rule_width / 2 - body_label_width / 2, d * i, 0 ]) cylinder(d = 1.6, h = 50, center = true);
        }
    }
}

module body_connector()
{

    translate([ 0, -connector_dy / 2, 0 ]) difference()
    {
        translate([ -connector_dx / 2, 0, body_thickness / 2 ])
        {
            cube([ connector_dx, connector_dy, window_height / 2 - body_thickness / 2 + 1 ]);
        }

        translate([ -rule_width / 2, -0.5, rule_thickness / 2 - 0.5 ])
            cube([ rule_width, connector_dy + 1, label_thickness + 1 ]);

        translate([ rule_width / 2 + body_label_width, -1, body_thickness / 2 ])
            cube([ key_width, connector_dy + 2, label_thickness ]);
    }
}

module rule()
{

    difference()
    {
        union()
        {
            rotate([ 90, 0, 0 ]) translate([ 0, 0, -length / 2 ])
            {
                linear_extrude(length)
                {
                    polygon(points = [
                        [ -rule_width / 2 - key_len + tol, key_width / 2 - tol ],
                        [ -rule_width / 2 + tol, key_width / 2 - tol ],
                        [ -rule_width / 2 + tol, rule_thickness / 2 ],
                        [ +rule_width / 2 - tol, rule_thickness / 2 ],
                        [ +rule_width / 2 - tol, key_width / 2 - tol ],
                        [ +rule_width / 2 + key_len - tol, key_width / 2 - tol ],
                        [ +rule_width / 2 + key_len - tol, -key_width / 2 + tol ],
                        [ +rule_width / 2 - tol, -key_width / 2 + tol ],
                        [ +rule_width / 2 - tol, -rule_thickness / 2 ],
                        [ -rule_width / 2 + tol, -rule_thickness / 2 ],
                        [ -rule_width / 2 + tol, -key_width / 2 + tol ],
                        [ -rule_width / 2 - key_len + tol, -key_width / 2 + tol ],
                    ]);
                }
            }

            translate([ -rule_width / 2 + tol, -length / 2, body_thickness / 2 ])
                cube([ rule_width - tol * 2, connector_dy, label_thickness ]);

            translate([ -rule_width / 2 + tol, length / 2 - connector_dy, body_thickness / 2 ])
                cube([ rule_width - tol * 2, connector_dy, label_thickness ]);

            translate([ -rule_width / 2 + tol, -length / 2, -body_thickness / 2 - label_thickness ])
                cube([ rule_width - tol * 2, connector_dy, label_thickness ]);

            translate([ -rule_width / 2 + tol, length / 2 - connector_dy, -body_thickness / 2 - label_thickness ])
                cube([ rule_width - tol * 2, connector_dy, label_thickness ]);
        }

        n = 19;
        d = (length - connector_dy * 3) / n / 2;
        for (i = [-n:2:n])
        {
            translate([ 0, d * i, 0 ]) cylinder(d = 1.6, h = 50, center = true);
        }
    }
}

module window()
{
    difference()
    {
        translate([ -window_width / 2, -window_length / 2, 0 ])
            cube([ window_width, window_length, window_height / 2 ]);

        translate([ -(rule_width + body_label_width * 2 + 2 * key_width + tol * 2) / 2, -window_length / 2, 0 ]) cube([
            rule_width + body_label_width * 2 + 2 * key_width + tol * 2, window_length,
            body_thickness / 2 + label_thickness + tol * 2
        ]);

        translate(
            [ window_width / 4 + rule_width / 4 + body_label_width / 2 + key_width / 2, window_length / 2 - 5, -0.1 ])
            cylinder(d = 2.5, h = 50);

        translate(
            [ window_width / 4 + rule_width / 4 + body_label_width / 2 + key_width / 2, -window_length / 2 + 5, -0.1 ])
            cylinder(d = 2.5, h = 50);

        translate([
            -(window_width / 4 + rule_width / 4 + body_label_width / 2 + key_width / 2), window_length / 2 - 5, -0.1
        ])
        {
            cylinder(d = 3.2, h = 50);
            translate([ 0, 0, 2 ]) cylinder(d = 8, h = 50);
        }

        translate([
            -(window_width / 4 + rule_width / 4 + body_label_width / 2 + key_width / 2), -window_length / 2 + 5, -0.1
        ])
        {
            cylinder(d = 3.2, h = 50);

            translate([ 0, 0, 2 ]) cylinder(d = 8, h = 50);
        }

        translate([
            -(rule_width / 2 + body_label_width + key_width) - tol, -window_length / 2 + 2,
            body_thickness / 2 + label_thickness +
            tol
        ])
        {
            cube([ rule_width + body_label_width * 2 + 2 * key_width + tol * 2, window_length - 4, 1.5 ]);
        }

        translate([
            -(rule_width / 2 + body_label_width + key_width) - tol, -window_length / 2 + 3,
            body_thickness / 2 + label_thickness +
            tol
        ])
        {
            cube([ rule_width + body_label_width * 2 + 2 * key_width + tol * 2, window_length - 6, 50 ]);
        }
        translate([ 0, 0, body_thickness / 2 + label_thickness + hair_d / 2 + tol * 2 ])
        {
            rotate([ 0, 90, 0 ])
            {
                cylinder(d = hair_d, h = 100, center = true);
            }
        }

        translate([ -(window_width / 4 + rule_width / 4 + body_label_width / 2 + key_width / 2), 0, 0 ])
        {
            cylinder(d = 1.6, h = 50, center = true);
        }

        translate([ (window_width / 4 + rule_width / 4 + body_label_width / 2 + key_width / 2), 0, 0 ])
        {
            cylinder(d = 1.6, h = 50, center = true);
        }
    }
}

color("red") body();
rotate([ 0, 180, 0 ]) body();

rule();
window();
color("red") rotate([ 0, 180, 0 ]) window();