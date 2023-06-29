/// @description Update every frame
// You can write your code in this editor

//Collision, using mask index instead of sprite index
var sprite_bbox_top = sprite_get_bbox_top(mask_index) - sprite_get_yoffset(mask_index);
var sprite_bbox_bottom = sprite_get_bbox_bottom(mask_index) - sprite_get_yoffset(mask_index) + 1;
var sprite_bbox_left = sprite_get_bbox_left(mask_index) - sprite_get_xoffset(mask_index);
var sprite_bbox_right = sprite_get_bbox_right(mask_index) - sprite_get_xoffset(mask_index) + 1;

//Snap coordinates
snap_x = 0;
snap_y = 0;
    
//Collisions (no slopes)
//Horizontal
for(var h=0;h<=ceil(abs(xspd));h++) {//Necessary for overspeed
    var wall_x = collision_real_id(h*sign(xspd),0,oSolid);//See edit below for "collision_real_id" function
    if wall_x != noone {
        var wall_left = wall_x.bbox_left;
        var wall_right = wall_x.bbox_right;
        if x < wall_left {//right
            snap_x = wall_left-sprite_bbox_right;
        } else if x > wall_right {//left
            snap_x = wall_right-sprite_bbox_left;
        }
        xspd = 0;
    }
}

//Vertical
for(var v=0;v<=ceil(abs(yspd));v++) {//Necessary for overspeed
    var wall_y = collision_real_id(0,v*sign(yspd),oSolid);//See edit below for "collision_real_id" function
    if wall_y != noone {
        var wall_top = wall_y.bbox_top;
        var wall_bottom = wall_y.bbox_bottom;
        if y < wall_top {//down
            snap_y = wall_top-sprite_bbox_bottom;
        } else if y > wall_bottom {//up
            snap_y = wall_bottom-sprite_bbox_top;
        }
        yspd = 0;
    }
}
    
x += xspd;
y += yspd;
if snap_x != 0 x = snap_x;
if snap_y != 0 y = snap_y;

//Check if landed/grounded (landed lasts for 1 step and cancels/ends attacking, pogoing, stunned)
if (place_meeting(x, y+1, oSolid))
{
	landed = (!grounded) ? true : false;
	grounded = true;
}
else
{
	landed = false;
	grounded = false;
}

//Run state machine
currentState();

//Invulnerability
if (invulnerableCounter > 0 && invulnerableCounter < 120)
{
	invulnerableCounter++;
}
else
{
	invulnerableCounter = 0;
}