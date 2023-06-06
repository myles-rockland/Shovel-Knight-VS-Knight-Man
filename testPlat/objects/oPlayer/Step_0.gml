/// @description Update every frame
// You can write your code in this editor
rightKey = keyboard_check(ord("D"));
leftKey = keyboard_check(ord("A"));
downKey = keyboard_check(ord("S"));
jumpKeyPressed = keyboard_check_pressed(vk_space);
jumpKeyHeld = keyboard_check(vk_space);
attackKeyPressed = keyboard_check_pressed(ord("J"));

//Movement
prevXSpd = xspd;
prevYSpd = yspd;
xspd = (rightKey - leftKey) * initMoveSpd;
//Left bias if both held
if (rightKey && leftKey)
{
	xspd = -1 * initMoveSpd;
}
//Start with slow movement speed for 3 frames
if (initMoveCounter < 5 && xspd != 0)
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
//Turning - currently causes weird teleport glitch if you slide into a wall
//If their input direction switched from last frame, carry their momentum for 4 frames, then stop for 4 frames
if ((place_meeting(x, y + 1, oSolid) && sign(prevXSpd) != 0 && sign(prevXSpd) * -1 == sign(xspd)) && turnAroundCounter == 0 || (turnAroundCounter > 0 && turnAroundCounter < 4))
{
	xspd = prevXSpd * 1/abs(prevXSpd);
	turnAroundCounter++;
}
else if (turnAroundCounter >= 4 && turnAroundCounter < 8)
{
	xspd = 0;
	turnAroundCounter++;
}
else
{
	if (turnAroundCounter == 8)
	{
		image_xscale *= -1; //flip sprite at end
	}
	turnAroundCounter = 0;
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

//Pogoing
if (!place_meeting(x, y + 1, oSolid) && downKey)
{
	pogoing = true;
}
else if (place_meeting(x, y + 1, oSolid))
{
	pogoing = false;
}

//Terminal falling velocity
if (yspd > 6)
{
	yspd = 6;
}

//Attacking - currently causes an issue with the animation
if (attackKeyPressed && ((attackBuffered && attackCounter == 0) || attackCounter == 0))
{
	attackCounter++;
	attackBuffered = false;
}
else if (attackCounter > 0 && attackCounter < 12)
{
	if (attackKeyPressed && attackCounter > 6)
	{
		attackBuffered = true;
	}
	attackCounter++;
}
if (attackCounter == 12)
{
	attackCounter = 0;
}
if (place_meeting(x, y + 1, oSolid) && attackCounter > 0)
{
	xspd = 0;
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

//Applying movement
x += xspd;
y += yspd;

//Sprite setting
if (place_meeting(x, y + 1, oSolid) && xspd == 0 && turnAroundCounter == 0 && !downKey) //idle
{
	sprite_index = sPlayerIdle;
	image_speed = 0;
}
if (attackCounter > 0) //Attack
{
	sprite_index = sPlayerAttack;
	image_speed = 1;
}
else if (place_meeting(x, y + 1, oSolid) && xspd == 0 && turnAroundCounter == 0 && downKey) //crouch
{
	sprite_index = sPlayerCrouch;
	image_speed = 0;
}
else if (place_meeting(x, y + 1, oSolid) && xspd == 1 && yspd == 0 && turnAroundCounter == 0) //running start
{
	sprite_index = sPlayerRunStart;
	image_speed = 1;
}
else if (place_meeting(x, y + 1, oSolid) && xspd != 0 && yspd == 0 && turnAroundCounter == 0) //running
{
	sprite_index = sPlayerRun;
	image_speed = 1;
}
else if (turnAroundCounter != 0) //turning
{
	sprite_index = sPlayerTurn;
	image_speed = 0;
	
}
else if (!place_meeting(x, y + 1, oSolid) && yspd < 2.5 && !pogoing) //jumping, with a small delay before falling sprite
{
	sprite_index = sPlayerJump;
	image_speed = 0;
}
else if (!place_meeting(x, y + 1, oSolid) && yspd >= 2.5 && !pogoing) //falling
{
	sprite_index = sPlayerFall;
	image_speed = 0;
}
else if (pogoing)
{
	sprite_index = sPlayerPogo;
	image_speed = 0;
}
if (xspd < 0) //Flip sprite left
{
	image_xscale = -1;
}
else if (xspd > 0) //Flip sprite right
{
	image_xscale = 1;
}