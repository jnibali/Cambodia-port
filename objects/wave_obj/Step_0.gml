
var t = (fadeDuration - alarm_get(0)) / fadeDuration;

if(dir > 0)
{
	image_alpha = quadInOut(t, 0, 1, dir);
}
else
{
	image_alpha = quadInOut(t, 1, -1, -dir);
}
