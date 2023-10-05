import wollok.game.*

object jugador{
	var property position = game.origin()
	var property arma = pistola
	
	method image(){ return "pepita.png" }
		
	method irA(newposition){
		position = newposition
	}
	
	method dispararArma(direc){
		arma.disparar(direc)
	}
}

object pistola{
	var property contador = 6
	var property cargador = [bala1,bala2,bala3,bala4,bala5,bala6,bala7]
	
	method disparar(direc){
		self.cargador().get(contador).disparo(direc)
		contador = contador - 1
		if (self.vacio()){self.recargar()}
	}
	
	method vacio(){return contador == -1}
	
	method recargar(){contador = 6}
}

class Proyectil{
	var property position = game.origin()
	
	method image() {return "alpiste.png"}
	
	method disparo(direc){
		game.addVisual(self)
		position = direc.mover(jugador)
		game.onTick(100,"fium", {position = direc.mover(self)})
		game.onCollideDo(self, {event => game.removeVisual(self)})
	}
}

object bala1 inherits Proyectil{}
object bala2 inherits Proyectil{}
object bala3 inherits Proyectil{}
object bala4 inherits Proyectil{}
object bala5 inherits Proyectil{}
object bala6 inherits Proyectil{}
object bala7 inherits Proyectil{}

object teste{
	method image(){return "silvestre.png"}
}