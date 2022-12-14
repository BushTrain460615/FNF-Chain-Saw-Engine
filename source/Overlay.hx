package;

import haxe.Timer;
import flixel.FlxG;
import openfl.Lib;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.system.System;

/**
 * Credits: Yoshubs.
 */
class Overlay extends TextField
{
	private var times:Array<Float> = [];
	private var memPeak:UInt = 0;

	public function new(x:Float, y:Float, color:Int)
	{
		super();

		this.x = x;
		this.y = x;

		this.autoSize = LEFT;
		this.selectable = false;
		this.mouseEnabled = false;

		this.defaultTextFormat = new TextFormat('_sans', 14, 0xFFFFFF);
		addEventListener(Event.ENTER_FRAME, function(e:Event)
		{
			var now = Timer.stamp();
			times.push(now);
			while (times[0] < now - 1)
				times.shift();

			var mem = System.totalMemory;
			if (mem > memPeak)
				memPeak = mem;

			if (visible)
				text = times.length + ' FPS\n${getInterval(mem)} / ${getInterval(memPeak)}\n';
		});
	}

	static final intervalArray:Array<String> = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

	public static function getInterval(num:UInt):String
	{
		var size:Float = num;
		var data = 0;

		while (size > 1024 && data < intervalArray.length - 1)
		{
			data++;
			size = size / 1024;
		}

		size = Math.round(size * 100) / 100;
		return size + " " + intervalArray[data];
	}
}
