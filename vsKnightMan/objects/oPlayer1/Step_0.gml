/// @description Update every frame
// You can write your code in this editor
rightKey = keyboard_check(ord("D"));
leftKey = keyboard_check(ord("A"));
downKey = keyboard_check(ord("S"));
jumpKeyPressed = keyboard_check_pressed(vk_space);
jumpKeyHeld = keyboard_check(vk_space);
attackKeyPressed = keyboard_check_pressed(ord("J"));

prevXSpd = xspd;
prevYSpd = yspd;

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

//Determine state from inputs
if (grounded && (rightKey || leftKey) && !jumpKeyPressed && !attackKeyPressed && attackCounter == 0 && turningCounter == 0)
{
	nextState = "running";
}
else if (grounded && downKey && !jumpKeyPressed && !attackKeyPressed && attackCounter == 0 && turningCounter == 0)
{
	nextState = "crouching";
}
else if (grounded && jumpKeyPressed && !attackKeyPressed && attackCounter == 0)
{
	attackCounter = 0;
	turningCounter = 0;
	nextState = "jumping";
}
else if (!grounded && !attackKeyPressed && attackCounter == 0 && currentState != "pogoing")
{
	nextState = "jumping";
}
else if (!grounded && !attackKeyPressed && attackCounter == 0 && currentState == "pogoing")
{
	nextState = "pogoing"
}
else if (attackKeyPressed || attackCounter != 0)
{
	turningCounter = 0;
	nextState = "attacking";
}
else if (grounded && turningCounter == 0)
{
	attackCounter = 0;
	turningCounter = 0;
	nextState = "idle";
}
else if (turningCounter > 0)
{
	nextState = "turning";
}
else if (attackCounter > 0)
{
	nextState = "attacking";
}

//Run state logic
currentState = nextState;
switch (currentState)
{
	case "idle":
		xspd = 0;
	break;
	case "crouching":
		xspd = 0;
	break;
	case "running":
		var moveDir = (rightKey - leftKey);
		if (rightKey && leftKey)
		{
			moveDir = -1;
		}
		if (runningInitCounter < 5 && abs(xspd) != runningSpeed)
		{
			runningInitCounter++;
			xspd = moveDir * runningInitSpeed;
		}
		else if (runningInitCounter == 5)
		{
			runningInitCounter = 0;
			xspd = moveDir * runningSpeed;
		}
		if (sign(prevXSpd) == -sign(xspd) && abs(prevXSpd) == runningSpeed)
		{
			nextState = "turning";
		}
		
	break;
	case "turning":
		if (turningCounter < 8)
		{
			turningCounter++
			if (turningCounter < 4)
			{
				xspd = prevXSpd;
			}
			else
			{
				xspd = 0;
			}
		}
		else
		{
			turningCounter = 0;
			runningInitCounter = 5;
			nextState = "running"
		}
		
	break;
	case "jumping":
		if (!hasJumped)
		{
			hasJumped = true;
			yspd = jumpSpd;
		}
		else if (grounded && hasJumped)
		{
			hasJumped = false;
		}
		if (yspd < 0 && !jumpKeyHeld)
		{
			yspd = max(yspd, yspd * (3/4));
		}
		if (attackKeyPressed)
		{
			nextState = "attacking";
		}
		else if (downKey)
		{
			nextState = "pogoing";
		}
	break;
	case "attacking":
		if (grounded && jumpKeyPressed)
		{
			yspd = jumpSpd;
		}
		if (attackCounter < 21)
		{
			attackCounter++;
		}
		else if (attackBuffered)
		{
			attackCounter = 0;
			nextState = "attacking"
		}
		else if (!grounded)
		{
			nextState = "jumping";
		}
		
	break;
	case "pogoing":
	break;
	case "stunned":
	break;
	case "dying":
	break;
}