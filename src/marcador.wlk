import personajes.*
import wollok.game.*

object marcador{
	var property position = game.at(2,game.height()-1)
	method text() = "Energia: " + bubba.energia()
	method puedeComerse() = false
}