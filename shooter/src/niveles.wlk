import jugador.*
import wollok.game.*

object nivel1 {

	method iniciar() {
		game.addVisual(jugador)
		config.teclas()
		game.addVisualIn(teste, game.at(10,10))
	}

}

object config {
	
	method teclas(){
		keyboard.a().onPressDo({ jugador.irA(jugador.position().left(1)) })
		keyboard.d().onPressDo({ jugador.irA(jugador.position().right(1))})
		keyboard.w().onPressDo({ jugador.irA(jugador.position().up(1))})
		keyboard.s().onPressDo({ jugador.irA(jugador.position().down(1))})
		
		keyboard.left().onPressDo({ jugador.disparar()})
		keyboard.right().onPressDo({ jugador.disparar()})
		keyboard.up().onPressDo({ jugador.disparar()})
		keyboard.down().onPressDo({ jugador.disparar()})

	}
	
	
}