/// @description Insert description here
// You can write your code in this editor
var enemy = instance_nearest(x, y, oEnemy);
image_xscale = enemy.image_xscale;
x = enemy.x - (16 * enemy.image_xscale);
y = enemy.y;
