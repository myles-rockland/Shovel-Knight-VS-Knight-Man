/// @description Insert description here
// You can write your code in this editor
rightKey = keyboard_check(ord("D"));
leftKey = keyboard_check(ord("A"));
jumpKeyPressed = keyboard_check_pressed(vk_space);
jumpKeyHeld = keyboard_check(vk_space);

xspd = (rightKey - leftKey) * initMoveSpd;
//Left bias if both held
if (rightKey && leftKey)
{
	xspd = -1 * initMoveSpd;
}
//Start with slow movement speed for 3 frames
if (initMoveCounter < 3 && xspd != 0)
{
	initMoveCounter++;
}
else if (xspd == 0)
{
	initMoveCounter = 0;
}
else
{
	xspd *= maxMoveSpd;
}
yspd += grav;

//Jumping
if (jumpKeyPressed && place_meeting(x, y + 1, oSolid))
{
	yspd = jumpSpd;
}
if (yspd < 0 && !jumpKeyHeld)
{
	yspd = max(yspd, -5);
}

//Collision checking
if (place_meeting(x + xspd, y, oSolid))
{
	x = round(x);
	var _pixelCheck = sign(xspd);
	while !place_meeting(x + _pixelCheck, y, oSolid)
	{
		x += _pixelCheck;
	}
	xspd = 0;
}

if (place_meeting(x + xspd, y + yspd, oSolid))
{
	y = round(y);
	var _pixelCheck = sign(yspd);
	while !place_meeting(x + xspd, y + _pixelCheck, oSolid)
	{
		y += _pixelCheck;
	}
	yspd = 0;
}

//Sprite setting
if (xspd == 0 && yspd == 0) //idle
{
	image_index = 0;
}
else if (xspd != 0 && yspd == 0) //running
{
	image_index = 1;
}
else if (yspd < 1) //jumping, with a small delay before falling sprite
{
	image_index = 2;
}
else if (yspd >= 1) //falling
{
	image_index = 3;
}
x += xspd;
y += yspd;