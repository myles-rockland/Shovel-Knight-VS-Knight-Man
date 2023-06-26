/// @description Insert description here
// You can write your code in this editor
//Direction pressed for one step
upPressed = keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(0, gp_padu) || (gamepad_axis_value(0,gp_axislv) < 0 && !upHeld);
downPressed = keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_padd) || (gamepad_axis_value(0,gp_axislv) > 0 && !downHeld);
leftPressed = keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(0, gp_padl) || (gamepad_axis_value(0,gp_axislh) < 0 && !leftHeld);
rightPressed = keyboard_check_pressed(ord("D")) || gamepad_button_check_pressed(0, gp_padr) || (gamepad_axis_value(0,gp_axislh) > 0 && !rightHeld);

//Direction held until released
upHeld = keyboard_check(ord("W")) || gamepad_button_check(0, gp_padu) || (gamepad_axis_value(0,gp_axislv) < 0);
downHeld = keyboard_check(ord("S")) || gamepad_button_check(0, gp_padd) || (gamepad_axis_value(0,gp_axislv) > 0);
leftHeld = keyboard_check(ord("A")) || gamepad_button_check(0, gp_padl) || (gamepad_axis_value(0,gp_axislh) < 0);
rightHeld = keyboard_check(ord("D")) || gamepad_button_check(0, gp_padr) || (gamepad_axis_value(0,gp_axislh) > 0);

//All other buttons
attackPressed = keyboard_check_pressed(ord("J")) || gamepad_button_check_pressed(0, gp_face3) || gamepad_button_check_pressed(0, gp_face2);
backPressed = keyboard_check_pressed(ord("J")) || gamepad_button_check_pressed(0, gp_face3) || gamepad_button_check_pressed(0, gp_face2);
jumpPressed = keyboard_check_pressed(ord("K")) || gamepad_button_check_pressed(0, gp_face1);
jumpHeld = keyboard_check(ord("K")) || gamepad_button_check(0, gp_face1);
confirmPressed = keyboard_check_pressed(ord("K")) || gamepad_button_check_pressed(0, gp_face1);
startPressed = keyboard_check_pressed(vk_enter) || gamepad_button_check_pressed(0, gp_start);
selectPressed = keyboard_check_pressed(ord("E")) || gamepad_button_check_pressed(0, gp_select);