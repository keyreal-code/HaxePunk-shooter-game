package ;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.Sfx;

/**
 * Enemy ship entity.
 * @author Kirill Poletaev
 */
class EnemyShip extends Entity
{
	private var speed:Int;
	private var health:Int;
	private var explosion:Explosion;
	private var score:Score;
	private var sfx_explosion:Sfx;
	private var sfx_hit:Sfx;
	private var lifeCounter:LifeCounter;

	public function new(g:Dynamic, explosion:Explosion, score:Score, lifeCounter:LifeCounter) 
	{
		super();
		graphic = g;
		this.explosion = explosion;
		this.score = score;
		this.lifeCounter = lifeCounter;
		speed = Math.ceil(Math.random() * 3);
		setHitbox(64, 48, 0, 0);
		health = 5;
		
		sfx_explosion = new Sfx("audio/explosion.wav");
		sfx_hit = new Sfx("audio/hit.wav");
	}
	
	override public function update() {
		this.y += speed;
		if (this.y > HXP.height) {
			scene.remove(this);
		}
		
		var collidedEntity = collide("bullet", x, y);
		if (collidedEntity != null) {
			health--;
			scene.remove(collidedEntity);
			explosion.explode(x, y);
			sfx_hit.play(1, (x/HXP.width)*1.6 - 0.8);
		}
		
		collidedEntity = collide("player", x, y);
		if (collidedEntity != null) {
			health = 0;
			lifeCounter.updateLives(-1);
			sfx_hit.play(1, (x/HXP.width)*1.6 - 0.8);
		}
		
		if (health == 0) {
			var i:Int = 0;
			while(i<3){
				explosion.explode(x, y);
				i++;
			}
			score.add(1);
			sfx_explosion.play(1, (x/HXP.width)*1.6 - 0.8);
			scene.remove(this);
		}
	}
	
}