import jugador.*
import wollok.game.*

object nivel1 {

	method iniciar() {
		game.addVisual(jugador)
		config.teclas()
		game.addVisualIn(teste, game.at(59,0))
	}

}

object config {
	
	method teclas(){
		keyboard.a().onPressDo({ jugador.irA(jugador.position().left(1)) })
		keyboard.d().onPressDo({ jugador.irA(jugador.position().right(1))})
		keyboard.w().onPressDo({ jugador.irA(jugador.position().up(1))})
		keyboard.s().onPressDo({ jugador.irA(jugador.position().down(1))})
		
		keyboard.left().onPressDo({ jugador.dispararArma(izquierda)})
		keyboard.right().onPressDo({ jugador.dispararArma(derecha)})
		keyboard.up().onPressDo({ jugador.dispararArma(arriba)})
		keyboard.down().onPressDo({ jugador.dispararArma(abajo)})

	}
}
	
object derecha {
	
	method mover(objeto){return objeto.position().right(1)}	
}

object izquierda {
	
	method mover(objeto){return objeto.position().left(1)}
		
}

object arriba {
	
	method mover(objeto){return objeto.position().up(1)}
		
}

object abajo {
	
	method mover(objeto){return objeto.position().down(1)}
		
}
	
	
