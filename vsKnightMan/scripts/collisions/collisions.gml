// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function collision_real(argument0,argument1,argument2) {
    var x_offset = argument0;
    var y_offset = argument1;
    var obj = argument2;
    var collision_detected = false;

    for(var i=0;i<instance_number(obj);i++) {
        var obj_id = instance_find(obj,i);
   
        if bbox_top + y_offset < obj_id.bbox_bottom
        && bbox_left + x_offset < obj_id.bbox_right
        && bbox_bottom + y_offset > obj_id.bbox_top
        && bbox_right + x_offset > obj_id.bbox_left {
            collision_detected = true;
        }
    }

    return collision_detected;
}

function collision_real_id(argument0,argument1,argument2) {
    var x_offset = argument0;
    var y_offset = argument1;
    var obj = argument2;
    var collision_id = noone;

    for(var i=0;i<instance_number(obj);i++) {
        var obj_id = instance_find(obj,i);
   
        if bbox_top + y_offset < obj_id.bbox_bottom
        && bbox_left + x_offset < obj_id.bbox_right
        && bbox_bottom + y_offset > obj_id.bbox_top
        && bbox_right + x_offset > obj_id.bbox_left {
            collision_id = obj_id;
        }
    }

    return collision_id;
}