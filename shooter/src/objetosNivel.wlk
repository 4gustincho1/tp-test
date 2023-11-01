import jugador.*
import enemigos.*
import niveles.*
import objetos.*
import wollok.game.*

object global{
	var property enemigos = []
	
	method agregar(nivelActual){
		enemigos = nivelActual.enemigos()
	}
}

object _nivel1{
    
	const property paredes = []
	const property enemigos = []
	const property objetos = [new MunicionPistola(position = game.at(5,17)), new MunicionRifle(position = game.at(12,27)), new MunicionGranada(position = game.at(25,5))]
	method pared(){
		(4..8).forEach({n => paredes.add(new Pared(position = game.at(0,n)))})  //usamos un rango para colocar paredes mas eficientemente 
		(0..7).forEach({n => paredes.add(new Pared(position = game.at(n,3)))})
		(0..7).forEach({n => paredes.add(new Pared(position = game.at(n,8)))}) // sala 1
		
		
		var inicioX = 9
		var finX = 19
		var inicioY = 5
		var finY = 13

		// Bucle forEach para agregar las paredes en el laberinto
		(inicioX..finX).forEach({ x =>
		    if (x != 14) {
		        paredes.add(new Pared(position = game.at(x, inicioY)))
		        paredes.add(new Pared(position = game.at(x, finY)))
		    }
		})
		(inicioY..finY).forEach({ y =>
		    if (y != 9) {
		        paredes.add(new Pared(position = game.at(inicioX, y)))
		        paredes.add(new Pared(position = game.at(finX, y)))
		    }
		})
		

		(9..13).forEach({n => paredes.add(new Pared(position = game.at(7,n)))})
		(15..15).forEach({n => paredes.add(new Pared(position = game.at(7,n)))})
		(4..15).forEach({n => paredes.add(new Pared(position = game.at(21,n)))})
		(7..13).forEach({n => paredes.add(new Pared(position = game.at(n,15)))})
		(15..21).forEach({n => paredes.add(new Pared(position = game.at(n,15)))})
		(7..23).forEach({n => paredes.add(new Pared(position = game.at(n,3)))}) // sala 2
		(9..29).forEach({n => paredes.add(new Pared(position = game.at(0,n)))})
		(7..29).forEach({n => paredes.add(new Pared(position = game.at(32,n)))})
		(3..5).forEach({n => paredes.add(new Pared(position = game.at(32,n)))})
		(1..32).forEach({n => paredes.add(new Pared(position = game.at(n,29)))})
		(24..31).forEach({n => paredes.add(new Pared(position = game.at(n,3)))}) // sala 3
		
		(1..3).forEach({n => paredes.add(new Pared(position = game.at(n,19)))})
		(5..6).forEach({n => paredes.add(new Pared(position = game.at(n,19)))})
		(21..24).forEach({n => paredes.add(new Pared(position = game.at(n,11)))})
		(26..31).forEach({n => paredes.add(new Pared(position = game.at(n,11)))})
		(1..3).forEach({n => paredes.add(new Pared(position = game.at(n,11)))})
		(4..6).forEach({n => paredes.add(new Pared(position = game.at(n,15)))})
		(4..6).forEach({n => paredes.add(new Pared(position = game.at(n,22)))})
		(26..28).forEach({n => paredes.add(new Pared(position = game.at(3,n)))})
		paredes.add(new Pared(position = game.at(14,15)))
		(22..28).forEach({n => paredes.add(new Pared(position = game.at(n,17)))})
		(20..16).forEach({n => paredes.add(new Pozo(position = game.at(19,n)))})
		
		var inicioX1 = 7
		var finX1 = 21
		var inicioY1 = 15
		var finY1 = 29

		// Bucle forEach para agregar las paredes en el laberinto
		(inicioX1..finX1).forEach({ x =>
		    if (x != 14) {
		        paredes.add(new Pared(position = game.at(x, inicioY1)))
		        paredes.add(new Pared(position = game.at(x, finY1)))
		    }
		})
		(inicioY1..finY1).forEach({ y =>
		    if (y != 24) {
		        paredes.add(new Pared(position = game.at(inicioX1, y)))
		        paredes.add(new Pared(position = game.at(finX1, y)))
		    }
		})
		
		var inicioX2 = 7
		var finX2 = 13
		var inicioY2 = 15
		var finY2 = 21

		// Bucle forEach para agregar las paredes en el laberinto
		(inicioX2..finX2).forEach({ x =>
		    if (x != 11) {
		        paredes.add(new Pared(position = game.at(x, inicioY2)))
		        paredes.add(new Pared(position = game.at(x, finY2)))
		    }
		})
		(inicioY2..finY2).forEach({ y =>
		    if (y != 19) {
		        paredes.add(new Pared(position = game.at(inicioX2, y)))
		        paredes.add(new Pared(position = game.at(finX2, y)))
		    }
		})
		
		var inicioX3 = 15
		var finX3 = 21
		var inicioY3 = 21
		var finY3 = 29

		// Bucle forEach para agregar las paredes en el laberinto
		(inicioX3..finX3).forEach({ x =>
		    if (x != 18) {
		        paredes.add(new Pared(position = game.at(x, inicioY3)))
		        paredes.add(new Pared(position = game.at(x, finY3)))
		    }
		})
		(inicioY3..finY3).forEach({ y =>
		    if (y != 24) {
		        paredes.add(new Pared(position = game.at(inicioX3, y)))
		        paredes.add(new Pared(position = game.at(finX3, y)))
		    }
		})
		paredes.forEach({pared => game.addVisual(pared)})
		
		game.addVisualIn(puertaDorada,game.at(7,14))
		game.addVisualIn(puertaAzul,game.at(4,19))
		game.addVisualIn(puertaVerde,game.at(7,24))
		game.addVisualIn(puertaRoja,game.at(21,24))
		game.addVisualIn(puertaNaranja,game.at(25,11))
		game.addVisualIn(puertaFinal,game.at(32,6))
		
	}
	
	method enemigo(){
		enemigos.clear()
		enemigos.add(new EnemigoBase(position = game.at(20,20)))
		enemigos.add(new Goblin(position = game.at(10,11)))
		enemigos.add(new Goblin(position = game.at(18,11)))
		enemigos.add(new Goblin(position = game.at(10,6)))
		enemigos.add(new Goblin(position = game.at(18,6)))
		enemigos.add(new BarrilExplosivo(position = game.at(17,25)))
		enemigos.forEach({enemigo => enemigo.inicializar()})
		
		global.agregar(self)
		
	}
	
	method pickups(){
		objetos.forEach({objeto=> game.addVisual(objeto)})
		game.addVisualIn(llaveDorada, game.at(20,5))
		game.addVisualIn(new NuevaVida(), game.at(1,9))
		game.addVisualIn(new NuevaVida(), game.at(8,16))
		game.addVisualIn(llaveAzul, game.at(11,11))
		game.addVisualIn(llaveVerde, game.at(1,12))
		game.addVisualIn(llaveRoja, game.at(1,28))
		game.addVisualIn(llaveNaranja, game.at(18,16))
		game.addVisualIn(new RiflePickup(), game.at(1,7))
		game.addVisualIn(new TeledirigidaPickup(), game.at(1,5))
	}
	
	
}
