/// @description Insert description here
// You can write your code in this editor
currentHealth = 0;
maxHealth = 20;

xspd = 0;
yspd = 0;
grav = 0.3;

/*
states =
[
	"idle",
	"running",
	"jumping",
	"swinging",
	"throwing",
	"bashing",
	"blockingUp",
	"blockingSide",
	"replenishing",
	"dying",
	"crouching",
	"teleporting"
]
*/

currentState = "replenishing";

grounded = false;
walled = false; //Boss becomes walled when bashing and colliding with wall;
idleCounter = 0; //Idle lasts up to 60 frames
runningCounter = 0; //Running lasts up to 120 frames
swingingCounter = 0; //Swinging lasts up to 60 frames
throwingCounter = 0; //Throwing lasts 39 frames
blockingCounter = 0; //Blocking (both up and side) lasts 120 frames
bashReadyCounter = 0; //Waits 30 frames before bashing
replenishCounter = 0; //Replenish 1 every 3 frames
hitCounter = 0;
hasJumped = false;
bashStarted = false;
replenished = false;
replenishedNum = 0; //Number of times replenished, replenishes once at start of fight, replenishes again at 6 health
deathLaunched = false;
playerMoved = false;