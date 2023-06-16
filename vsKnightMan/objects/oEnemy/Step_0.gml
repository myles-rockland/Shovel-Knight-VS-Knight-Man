/// @description Insert description here
// You can write your code in this editor
player = instance_nearest(x, y, oPlayer);

//Apply movement
x += xspd;
y += yspd;

//Apply gravity
yspd += grav;

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
	walled = true;
}
else
{
	walled = false;
}

if (place_meeting(x + xspd, y + yspd, oSolid))
{
	y = round(y);
	var _pixelCheck = sign(yspd);
	while !place_meeting(x + xspd, y + _pixelCheck, oSolid)
	{
		y += _pixelCheck;
	}
	grounded = true;
	yspd = 0;
}
else
{
	grounded = false;
}

//Do stuff based on current state
currentState = nextState;
switch (currentState)
{
	case "idle":
		idleCounter++;
		xspd = 0;
		if (player.x > x - 32 && player.x < x + 32 && player.y < y)
		{
			idleCounter = 0;
			nextState = "blockingUp"
		}
		else if (player.y == y && ((player.x > x - 48 && player.x < x) || (player.x < x + 48 && player.x > x)))
		{
			idleCounter = 0;
			nextState = "blockingSide"
		}
		else if (idleCounter == 60)
		{
			idleCounter = 0;
			nextState = "running";
		}
		else if (currentHealth == 6 && !replenished)
		{
			idleCounter = 0;
			nextState = "replenishing";
		}
	break;
	case "running":
		runningCounter++;
		if (hitFromSide)
		{
			runningCounter = 0;
			nextState = "bashing";
		}
		else if (hitFromAbove)
		{
			runningCounter = 0;
			nextState = "swinging";
		}
		else if (runningCounter == 120)
		{
			runningCounter = 0;
			nextState = "throwing";
		}
		else
		{
			xspd = 1.5 * sign(player.x - x);
		}
	break;
	case "jumping":
		if (grounded && !hasJumped)
		{
			hasJumped = true;
			yspd = -8;
			xspd = 1.5 * sign(player.x - x);
		}
		else if (grounded && hasJumped)
		{
			hasJumped = false;
			nextState = "idle";
		}
	break;
	case "swinging":
		swingingCounter++;
		xspd = 0;
		if (player.stunned) //Not sure how to determine if player gets hit as yet. Should be done inside enemy object I think.
		{
			swingingCounter = 0;
			nextState = "idle";
		}
		else if (swingingCounter == 60)
		{
			swingingCounter = 0;
			nextState = "throwing";
		}
	break;
	case "throwing":
		throwingCounter++;
		xspd = 0;
		if (throwingCounter == 39)
		{
			throwingCounter = 0;
			nextState = "idle";
		}
	break;
	case "bashing":
		if (!walled && !bashStarted)
		{
			bashStarted = true;
			xspd = 2 * sign(player.x - x);
		}
		else
		{
			bashStarted = false;
			nextState = "idle";
		}
	break;
	case "blockingUp":
		blockingCounter++;
		if (player.pogoing)
		{
			blockingCounter = 0;
			nextState = "swinging";
		}
		else if (blockingCounter == 120)
		{
			blockingCounter = 0;
			nextState = "jumping";
		}
	break;
	case "blockingSide":
		blockingCounter++;
		if (player.attackCounter > 0)
		{
			blockingCounter = 0;
			nextState = "bashing";
		}
		else if (blockingCounter == 120)
		{
			blockingCounter = 0;
			nextState = "jumping";
		}
	break;
	case "replenishing":
		currentHealth = 20;
		replenished = true;
		nextState = "idle";
	break;
	case "dying":
		if (grounded && !deathLaunched)
		{
			deathLaunched = true;
			xspd = 2 * -image_xscale;
			yspd = -5;
		}
		else if (grounded && deathLaunched)
		{
			xspd = 0;
			nextState = "crouching";
		}
		
	break;
	case "crouching":
	break;
	case "teleporting":
	break;
}
if (currentHealth == 0)
{
	nextState = "dying";
}