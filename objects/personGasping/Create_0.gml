/// @description Insert description here
// You can write your code in this editor
GASP_FLOAT_DISTANCE  = 10;	
		
MIN_FLOAT_X  = 0;			
MAX_FLOAT_X  = 0;	// 20	
MIN_FLOAT_Y  = GASP_FLOAT_DISTANCE;		
MAX_FLOAT_Y  = GASP_FLOAT_DISTANCE;
HANG_TIME  = 0; 	// Time at top of wave, before floating back down
FLOAT_DURATION  = 1;	// Used INSTEAD of FLOAT_SPEED, depending on which you want to be constant
		
MIN_ANGLE_CHANGE  = 0;
MAX_ANGLE_CHANGE  = 0;

floatXDirection = noone;
floatX = noone;
floatY = noone;
angleChange = noone;
//breathDuration = 0.5;
breathScale = 0.3;

firstGasp = true;
healthyAgain = false;

//sound

alarm[0] = room_speed;

Health = 100;
maxHealth = 100;


function added()
{
floatDown();
breatheIn(0.1);
//sndSplashUp.play();
			
			// heartbeat
//heartbeatFader = new SfxFader(sndHeartbeat, stopHearbeat);
//addTween(heartbeatFader);
//heartbeatFader.fadeTo(0, 2);
			
}


function playGaspingSound()
{
	//audio for gasping	
}

function scaredMoverCallback()
{
	if (distance_to_object(MouseController) < global.scareDistance)
	{
		scare();
	}
	else
	{
	speed = 0;
	scared = false;
	terrified = false;
				
	if (y > floatLevel)
		floatUp();
	else
		floatDown();
			
	}
}	


 function changeToFloater()
		{
			
			//addTween(sndGaspingFader);
			//sndGaspingFader.fadeTo(0, 10, Ease.quadIn);
			
			var floater = instance_create_depth(x,y,depth,personFloating)
			
			floater.breathDuration = breathDuration;
			floater.breathScale = breathScale;
			floater.image_xscale = image_xscale
			floater.image_yscale = image_yscale
			floater.terrify();
			floater.shakeAmount = shakeAmount;
			
			alarm[0] = -1; //end float alarm
			instance_destroy()
			
		}

function breatheIn(duration)
		{
			breathDirection = 1;
			//trace('breathe in');
			if (duration == 0) 
				duration = breathDuration;
			// Scale tween
			image_xscale = 1 + breathScale;
			image_yscale = image_xscale;
		}

 function breatheOut()
	{
		breathDirection = -1;
			
		
		image_xscale = 1 - breathScale;
		image_yscale = image_xscale;
			//breathScale -= BREATH_SCALE_CHANGE;
			//breathDuration += BREATH_DURATION_CHANGE;			
	}

function getFloaterDelay()
		{
			
			
			
			if ( personFloating.instance_count > 0) 
			{
				for (var i = 0; i < instance_number(personFloating); ++i;)
				{	
					 floatingList[i] = instance_find(personFloating,i);
				}
				
				for(var p = 0; p < array_length_1d(floatingList); p++)
				{
					var percent = x/(floatX +x)
					
					var phaseDelay;
					//p.image.scale = 5;
					
					if (floatX + x < x)
					{
						
						if (floatY < 0)
							phaseDelay = (x - (floatX + x)) / global.PHASE_DELAY_DIVIDER + (1 - percent) * variable_instance_get(personFloating,"FLOAT_DURATION") + variable_instance_get(personFloating,"FLOAT_DURATION");
						else
							phaseDelay = (x - (floatX + x)) / global.PHASE_DELAY_DIVIDER + (1 - percent) * variable_instance_get(personFloating,"FLOAT_DURATION");
					}
					else
					{
									
						if (y - floatY < 0)
							phaseDelay = (1 - percent) * variable_instance_get(personFloating,"FLOAT_DURATION") + variable_instance_get(personFloating,"FLOAT_DURATION") - ((floatX + x) - x) / global.PHASE_DELAY_DIVIDER;
						else
							phaseDelay = (1 - percent) * variable_instance_get(personFloating,"FLOAT_DURATION") - ((floatX + x) - x) / global.PHASE_DELAY_DIVIDER;
						while (phaseDelay < 0)
						{
							phaseDelay += (variable_instance_get(personFloating,"FLOAT_DURATION") * 2);
							
						}
					}	
					break;
				}	
				
				return(phaseDelay + variable_instance_get(personFloating,"FLOAT_DURATION") * 4);
			}
			return 0;
		}


		function floatDown()
		{
			floatXDirection = choose(-1, 1);
			floatX = MIN_FLOAT_X + random_range(0,1) * (MAX_FLOAT_X - MIN_FLOAT_X);
			floatX = floatX * floatXDirection;
			if (x + 2 * floatX < 0 || x + 2 * floatX > room_width)
			{
				floatXDirection *= -1;
				floatX *= -1;
			}
			floatY = MIN_FLOAT_Y + random_range(0,1) * (MAX_FLOAT_Y - MIN_FLOAT_Y);
			
			var duration = FLOAT_DURATION + floatX / global.PHASE_DELAY_DIVIDER;
			
				
			move_towards_point(x+floatX,y+floatY,duration)
			
			//trace('floatX: ' + floatX);
			//trace('duration: ' + duration);			
			
			// Angle tween
			angleChange = MIN_ANGLE_CHANGE + random_range(0,1) * (MAX_ANGLE_CHANGE - MIN_ANGLE_CHANGE);
			angleChange *= -floatXDirection;
			image_angle += sin(degtorad(angleChange - image_angle))*duration
		}
		
		 function floatUp()
		{
			
			var duration = FLOAT_DURATION * 1;
			
			move_towards_point(x+floatX,y - floatY,duration)
			
			// Angle tween
			
			image_angle += sin(degtorad((-angleChange) - image_angle))*duration
		}	