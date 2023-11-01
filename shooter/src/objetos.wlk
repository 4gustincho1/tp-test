import jugador.*
import enemigos.*
import objetosNivel.*
import wollok.game.*
import menu.*

class Objeto {
	var property position = game.at(0,0)
	method solido() = false // si colisiona con jugador y enemigos
	method golpeable() = false // si colisiona con balas
	method destruible() = false // si puede ser destruido
	method recogible() = false
	method abrible() = false
	method esEnemigo()=false
	method transparente()=true
}

class Pared inherits Objeto{
	method image(){return "pared.png"}
	override method solido() = true
	override method golpeable() = true
	override method transparente() = false
}

class Pozo inherits Objeto{
	method image(){return "pozo.png"}
	override method solido() = true
}

object puertaDorada inherits Pared{
	override method image(){return "PuertaCerradaDorada.png"} 
	override method abrible() = true
	
	method abrir(){
		if(jugador.inventario().contains(llaveDorada)){
		jugador.inventario().remove(llaveDorada)
		game.removeVisual(self)
		}
	}
	
}

object puertaAzul inherits Pared{
	override method image(){return "PuertaCerradaAzul.png"} 
	override method abrible() = true
	
	method abrir(){
		if(jugador.inventario().contains(llaveAzul)){
		jugador.inventario().remove(llaveAzul)
		game.removeVisual(self)
		}
	}
}

object puertaVerde inherits Pared{
	override method image(){return "PuertaCerradaVerde.png"} 
	override method abrible() = true
	
	method abrir(){
		if(jugador.inventario().contains(llaveVerde)){
		jugador.inventario().remove(llaveVerde)
		game.removeVisual(self)
		}
	}
}

object puertaRoja inherits Pared{
	override method image(){return "PuertaCerradaRoja.png"} 
	override method abrible() = true
	
	method abrir(){
		if(jugador.inventario().contains(llaveRoja)){
		jugador.inventario().remove(llaveRoja)
		game.removeVisual(self)
		}
	}
}

object puertaNaranja inherits Pared{
	override method image(){return "PuertaCerradaNaranja.png"} 
	override method abrible() = true
	
	method abrir(){
		if(jugador.inventario().contains(llaveNaranja)){
		jugador.inventario().remove(llaveNaranja)
		game.removeVisual(self)
		}
	}
}



class Pickup inherits Objeto{
	override method recogible()	= true 
	method pickup(){
		jugador.inventario().add(self)
		game.removeVisual(self)
	}
}

object llaveDorada inherits Pickup{
	method image(){return "llaveDorada.png"}
}

object llaveAzul inherits Pickup{
	method image(){return "llaveAzul.png"}
}

object llaveVerde inherits Pickup{
	method image(){return "llaveVerde.png"}
}

object llaveRoja inherits Pickup{
	method image(){return "llaveRoja.png"}
}

object llaveNaranja inherits Pickup{
	method image(){return "llaveNaranja.png"}
}

class RiflePickup inherits Pickup{
	method image() {return "riflePickup.png"}
	override method pickup(){
		jugador.setArmas().add(JugadorRifle)
		game.removeVisual(self)
	}
}

class TeledirigidaPickup inherits Pickup{
	method image() {return "teledirigidaPickup.png"}
	override method pickup(){
		jugador.setArmas().add(LanzadorTeledirigido)
		game.removeVisual(self)
	}
}


class NuevaVida inherits Pickup{
	method image() {return "vida.png"}
	
	override method pickup(){
		jugador.vidas().add(new Vida())
		game.removeVisual(self)
		
		game.addVisualIn(jugador.vidas().get(jugador.vidas().size() - 1), game.at(jugador.vidas().size(), 1))
		
	}
}


class MunicionPistola inherits Pickup{
	method image(){return "pistolaClip.png"}
	override method pickup(){JugadorPistola.recargar()
	game.removeVisual(self)	
	}
	
}

class MunicionRifle inherits Pickup{
	method image(){return "rifleCargador.png"}
	override method pickup(){JugadorRifle.recargar()
	game.removeVisual(self)
	}
}

class MunicionGranada inherits Pickup{
	method image(){return "granada.png"}
	override method pickup(){
		jugador.setArmas().add(JugadorGranada)
		JugadorGranada.recargar()
	game.removeVisual(self)
	}
}

class MunicionMana inherits Pickup{
	method image(){return "manaPickup.png"}
	override method pickup(){LanzadorTeledirigido.recargar()
	game.removeVisual(self)
	}
}



class Explosion inherits Objeto{
	method image(){return "explosion.png"}
	
	method explotar(positionX, positionY){
		game.addVisualIn(self, game.at(positionX,positionY))
		game.schedule(500,({game.removeVisual(self)}))
		8.times({i=>impacto.impactar(self)})
	}
}

object puertaFinal inherits Objeto{
	method image(){return "puertaFinal.png"}
	override method abrible() = true
	
	method abrir(){
		self.finDelJuego()
	}
	
	method finDelJuego(){
		//game.removeVisual(self)//<--Para implementar el menu de win comentar esto
		//game.say(jugador, "Ganaste!!!")//<--Para implementar el menu de win comentar esto
		//game.schedule(3000, { => game.stop()})//<--Para implementar el menu de win comentar esto
		ganarLvl1.iniciar()//<--Para implementar el menu de win descomentar esto
	}
}

