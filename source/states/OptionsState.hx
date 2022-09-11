package states;

import flixel.FlxG;
import flixel.FlxSprite;
import substates.ControlsSubState;
import flixel.group.FlxGroup.FlxTypedGroup;

class OptionsState extends MusicBeatState
{
	private static var curSelected:Int = 0;

	private var grpOptions:FlxTypedGroup<Alphabet>;

	private var options:Array<String> = ['Preferences', 'Controls', 'Exit'];

	override function create()
	{
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFea71fd;
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true, false);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		changeSelection();

		super.create();
	}

	override function closeSubState()
	{
		super.closeSubState();

		PreferencesData.write();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UI_UP_P)
			changeSelection(-1);
		else if (controls.UI_DOWN_P)
			changeSelection(1);
		else if (FlxG.mouse.wheel != 0)
			changeSelection(-FlxG.mouse.wheel);

		if (controls.ACCEPT)
		{
			switch (options[curSelected])
			{
				case 'Preferences':
					//openSubState(new ui.PreferencesMenu());
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxG.switchState(new MainMenuState());
				case 'Controls':
					openSubState(new ControlsSubState());
				case 'Exit':
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxG.switchState(new MainMenuState());
			}
		}
	}

	private function changeSelection(change:Int = 0)
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = options.length - 1;

		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0)
				item.alpha = 1;
		}

		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}