/// @description Insert description here
// You can write your code in this editor
rightKey = keyboard_check(ord("D"));
leftKey = keyboard_check(ord("A"));
jumpKeyPressed = keyboard_check_pressed(vk_space);

xspd = (rightKey - leftKey) * moveSpd;
yspd += grav;

if (jumpKeyPressed && place_meeting(x, y + 1, oSolid))
{
	yspd = jumpSpd;
}

if (place_meeting(x + xspd, y, oSolid))
{
	var _pixelCheck = sign(xspd);
	while !place_meeting(x + _pixelCheck, y, oSolid)
	{
		x += _pixelCheck;
	}
	xspd = 0;
}

if (place_meeting(x + xspd, y + yspd, oSolid))
{
	var _pixelCheck = sign(yspd);
	while !place_meeting(x + xspd, y + _pixelCheck, oSolid)
	{
		y += _pixelCheck;
	}
	yspd = 0;
}
x += xspd;
y += yspd;