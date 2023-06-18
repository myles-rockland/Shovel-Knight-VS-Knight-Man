/// @description Insert description here
// You can write your code in this editor
player = instance_nearest(x, y, oPlayer1);

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
	var _pixelCheck = sign(yspd) * abs(grav);
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

//Apply movement
x += xspd;
y += yspd;

//Player collision checking
if (player.currentState == "pogoing" && place_meeting(x, y - 1, oPlayer1) && currentState != "swinging" && currentState != "dying" && currentState != "teleportingOut" && currentState != "crouching")
{
	player.yspd = player.jumpSpd;
	if (currentState != "replenishing" && currentState != "blockingUp" && player.pogoDelay == 0)
	{
		currentHealth--;
		hitCounter = 1;
		player.pogoDelay++;
	}
}
else if (currentState != "dying" && currentState != "teleportingOut" && currentState != "crouching" && player.currentState != "dead" && player.currentState != "dying" && player.currentState != "stunned" && player.invulnerableCounter == 0 && (place_meeting(x + xspd, y, oPlayer1) || place_meeting(x + xspd, y + yspd, oPlayer1)))
{
	player.currentState = "stunned";
	player.yspd = -3;
	player.currentHealth--;
	if (player.currentHealth == 0)
	{
		player.yspd = -5;
	}
}
if (hitCounter > 0 && hitCounter < 30)
{
	hitCounter++;
}
else
{
	hitCounter = 0;
}

//Do stuff based on current state
switch (currentState)
{
	case "idle":
		image_xscale = sign(player.x - x)
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
		idleCounter++;
		xspd = 0;
		if (player.x > x - 32 && player.x < x + 32 && player.y < y)
		{
			idleCounter = 0;
			currentState = "blockingUp"
		}
		else if (player.grounded && grounded && ((player.x > x - 80 && player.x < x) || (player.x < x + 80 && player.x > x)))
		{
			idleCounter = 0;
			currentState = "blockingSide"
		}
		else if (idleCounter == 60)
		{
			idleCounter = 0;
			currentState = "running";
		}
	break;
	case "running":
		runningCounter++;
		if (instance_exists(oPlayerAttackHitbox) && place_meeting(x, y, oPlayerAttackHitbox))
		{
			runningCounter = 0;
			currentState = "bashReady";
		}
		else if (player.currentState == "pogoing" && place_meeting(x, y, oPlayer1))
		{
			runningCounter = 0;
			currentState = "swinging";
		}
		else if (runningCounter == 120)
		{
			runningCounter = 0;
			currentState = "throwing";
		}
		else if (player.grounded && player.jumpKeyPressed)
		{
			runningCounter = 0;
			currentState = choose("jumping", "bashReady");
		}
		else
		{
			xspd = 2 * sign(player.x - x);
		}
	break;
	case "jumping":
		if (grounded && !hasJumped)
		{
			hasJumped = true;
			yspd = -8;
			xspd = (player.x - x)/48; //1.5 * sign(player.x - x)
		}
		else if (grounded && hasJumped)
		{
			hasJumped = false;
			currentState = "idle";
		}
	break;
	case "swinging":
		swingingCounter++;
		xspd = 0;
		if (player.currentState != "stunned" && player.invulnerableCounter == 0 && (place_meeting(x + xspd, y, oPlayer1) || place_meeting(x + xspd, y + yspd, oPlayer1)))
		{
			swingingCounter = 0;
			currentState = "idle";
		}
		else if (swingingCounter == 60)
		{
			swingingCounter = 0;
			currentState = "throwing";
		}
	break;
	case "throwing":
		throwingCounter++;
		if (throwingCounter == 4)
		{
			instance_create_layer(x + (image_xscale * 40), y, "Instances", oEnemyAttackHitbox);
		}
		xspd = 0;
	break;
	case "bashReady":
		image_xscale = sign(player.x - x);
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
		xspd = 0;
		bashReadyCounter++;
		if (bashReadyCounter == 30)
		{
			bashReadyCounter = 0;
			currentState = "bashing";
		}
	break;
	case "bashing":
		if (!bashStarted)
		{
			bashStarted = true;
			xspd = 6 * sign(player.x - x);
		}
		else if (walled && bashStarted)
		{
			bashStarted = false;
			currentState = "idle";
		}
	break;
	case "blockingUp":
		blockingCounter++;
		if (player.currentState == "pogoing" && place_meeting(x, y, oPlayer1))
		{
			blockingCounter = 0;
			currentState = "swinging";
		}
		else if ((instance_exists(oPlayerAttackHitbox) && place_meeting(x, y, oPlayerAttackHitbox)) || blockingCounter == 120)
		{
			blockingCounter = 0;
			currentState = "jumping";
		}
	break;
	case "blockingSide":
		blockingCounter++;
		image_xscale = sign(player.x - x);
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
		if (player.attackCounter == 5)
		{
			blockingCounter = 0;
			currentState = "bashReady";
		}
		else if (player.currentState == "pogoing" && place_meeting(x, y, oPlayer1))
		{
			blockingCounter = 0;
			currentState = "swinging";
		}
		else if (blockingCounter == 120)
		{
			blockingCounter = 0;
			currentState = "jumping";
		}
	break;
	case "replenishing":
		xspd = 0;
		replenishCounter++;
		image_xscale = sign(player.x - x);
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
		if (currentHealth < 20 && replenishCounter == 3)
		{
			currentHealth++;
			replenishCounter = 0;
		}
	break;
	case "dying":
		if (!deathLaunched)
		{
			deathLaunched = true;
			xspd = 2 * -image_xscale;
			yspd = -5;
		}
		else if (grounded && deathLaunched)
		{
			xspd = 0;
			currentState = "crouching";
		}
		
	break;
	case "crouching":
		image_xscale = sign(player.x - x)
		if (image_xscale == 0)
		{
			image_xscale = 1;
		}
		if (player.attackCounter > 0) //Should check to see if dialogue is done, placeholder condition for now
		{
			currentState = "teleportingOut";
		}
	break;
	case "teleportingOut":
		yspd = 0;
	break;
}
if (currentHealth == 0 && !deathLaunched && replenished)
{
	currentState = "dying";
}
if (currentHealth <= 6 && grounded && !replenished && currentState != "bashing" && currentState != "bashReady")
{
	yspd = 0;
	idleCounter = 0;
	runningCounter = 0;
	swingingCounter = 0;
	throwingCounter = 0;
	blockingCounter = 0;
	bashReadyCounter = 0;
	hasJumped = false;
	bashStarted = false;
	currentState = "replenishing";
}