package ;
import com.haxepunk.Entity;
import com.haxepunk.graphics.atlas.AtlasRegion;
import com.haxepunk.graphics.atlas.TextureAtlas;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

/**
 * Player ship.
 * @author Kirill Poletaev
 */
class PlayerShip extends Entity
{
	private var movespeed:Int;
	private var bulletDelay:Int;
	private var currentDelay:Int;
	private var atlas:TextureAtlas;
	private var alternateCannon:Bool;
	private var bulletImage:Image;
	private var sfx_shoot:Sfx;

	public function new(atlas:TextureAtlas) 
	{
		super();
		graphic = new Image(atlas.getRegion("playerShip"));
		movespeed = 8;
		width = 64;
		height = 48;
		x = HXP.width/2 - width/2;
		y = HXP.height - 80;
		bulletDelay = 5;
		currentDelay = 0;
		this.atlas = atlas;
		alternateCannon = true;
		bulletImage = new Image(atlas.getRegion("bullet"));
		
		sfx_shoot = new Sfx("audio/shoot.wav");
		
		type = "player";
		setHitbox(64, 48, 0, 0);
	}
	
	override public function update() {
		if (Input.check("down")) {
			moveBy(0, movespeed);
		}
		if (Input.check("up")) {
			moveBy(0, -movespeed);
		}
		if (Input.check("right")) {
			moveBy(movespeed, 0);
		}
		if (Input.check("left")) {
			moveBy(-movespeed, 0);
		}
		
		if (this.x < 0) this.x = 0;
		if (this.y < 0) this.y = 0;
		if (this.x > HXP.width - width) this.x = HXP.width - width;
		if (this.y > HXP.height - height) this.y = HXP.height - height;
		
		if (Input.check(Key.SPACE)) {
			if (currentDelay == 0) {
				currentDelay = bulletDelay;
				var b:Bullet = new Bullet(bulletImage);
				scene.add(b);
				if(alternateCannon){
					b.x = x;
				}else {
					b.x = x + 50;
				}
				alternateCannon = !alternateCannon;
				sfx_shoot.play(0.7, (x/HXP.width)*1.6 - 0.8);
				b.y = y;
			}
		}
		if (currentDelay > 0) {
			currentDelay--;
		}
	}
	
}