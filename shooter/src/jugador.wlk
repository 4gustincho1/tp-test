import wollok.game.*

object jugador{
	var property position = game.origin()
	var property contador = ""
	
	method image(){ return "pepita.png" }
		
	method irA(newposition){
		position = newposition
	}	
	
	method disparar(){
		contador = ["bala",pistola.cargador().toString()].join("")
		
		contador.disparo()
	}
	
}

object pistola{
	var property cargador = 7
}

class Proyectil{
	var property position = game.origin()
	
	method image() {return "alpiste.png"}
	
	method disparo(){
		game.addVisual(self)
		position = jugador.position().right(1)
		game.onTick(100,"fium", {position = self.position().right(1)})
		game.onCollideDo(self, {event => 
			game.removeVisual(self)
			game.removeTickEvent("fium")
		})
		
		
	}
	
}
const bala1 = new Proyectil()
const bala2 = new Proyectil()
const bala3 = new Proyectil()
const bala4 = new Proyectil()
const bala5 = new Proyectil()
const bala6 = new Proyectil()
const bala7 = new Proyectil()

object teste{
	method image(){return "silvestre.png"}
}