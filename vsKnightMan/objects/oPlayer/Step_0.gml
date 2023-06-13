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
//Turning
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
if (yspd < 0 && !jumpKeyHeld && !pogoing)
{
	yspd = max(yspd, -5);
}

//Pogoing
if (!place_meeting(x, y + 1, oSolid) && downKey && attackCounter == 0)
{
	pogoing = true;
}
else if (place_meeting(x, y + 1, oSolid) || stunned || attackCounter > 0)
{
	pogoing = false;
}

//Terminal falling velocity
if (yspd > 6)
{
	yspd = 6;
}

//Attacking
if (attackCounter == 0 && (attackKeyPressed || attackBuffered))
{
	attackCounter++;
	attackBuffered = false;
}
else if (attackCounter > 0 && attackCounter < 21)
{
	if (attackKeyPressed && attackCounter > 4)
	{
		attackBuffered = true;
	}
	attackCounter++;
}
if (attackCounter == 21)
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
	turnAroundCounter = 0;
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
	stunned = false;
}

//Cancel attack
if (prevYSpd > 0 && yspd == 0 || prevYSpd == 0 && yspd < 0 || stunned)
{
	attackCounter = 0;
	attackBuffered = false;
}

//Enemy collision checking
if (place_meeting(x + xspd, y, oEnemy) && !stunned && invulnerableCounter == 0)
{
	xspd = -image_xscale * 2;
	yspd = -4;
	turnAroundCounter = 0;
	attackCounter = 0;
	stunned = true;
	invulnerableCounter++;
}
else if (place_meeting(x + xspd, y + yspd, oEnemy) && !pogoing && !stunned && invulnerableCounter == 0)
{
	xspd = -image_xscale * 2;
	yspd = -4;
	turnAroundCounter = 0;
	attackCounter = 0;
	stunned = true;
	invulnerableCounter++;
}
else if (place_meeting(x + xspd, y + yspd, oEnemy) && pogoing)
{
	yspd = -8.5;
}
else if (stunned)
{
	xspd = prevXSpd;
}
if (invulnerableCounter > 0)
{
	invulnerableCounter++;
	image_alpha = int64(invulnerableCounter % 3 == 0);
	if (invulnerableCounter == 120)
	{
		invulnerableCounter = 0;
	}
}

//Applying movement
x += xspd;
y += yspd;

//Sprite setting
if (stunned)
{
	sprite_index = sPlayerStunned;
	image_speed = 0;
}
else if (place_meeting(x, y + 1, oSolid) && (!leftKey && !rightKey) && turnAroundCounter == 0 && !downKey && attackCounter == 0) //idle
{
	sprite_index = sPlayerIdle;
	image_speed = 0;
}
else if (attackCounter > 0 || attackBuffered) //Attack
{
	sprite_index = sPlayerAttack;
	image_speed = 1;
}
else if (place_meeting(x, y + 1, oSolid) && xspd == 0 && turnAroundCounter == 0 && downKey) //crouch
{
	sprite_index = sPlayerCrouch;
	image_speed = 0;
}
else if (place_meeting(x, y + 1, oSolid) && (xspd == 1 || xspd == -1) && yspd == 0 && turnAroundCounter == 0) //running start
{
	sprite_index = sPlayerRunStart;
	image_speed = 1;
}
else if (place_meeting(x, y + 1, oSolid) && (rightKey || leftKey) && yspd == 0 && turnAroundCounter == 0) //running
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
if (xspd != 0) //Flip sprite
{
	image_xscale = sign(xspd);
}
if (stunned)
{
	image_xscale *= -1;
}