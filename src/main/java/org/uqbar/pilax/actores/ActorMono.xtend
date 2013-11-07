package org.uqbar.pilax.actores

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.motor.ImagenMotor

class ActorMono extends Actor {
	ImagenMotor image_normal
	ImagenMotor image_smile
	ImagenMotor image_shout
	
	new() {
		this(0, 0)
	}
	
	new(int x, int y) {
		super('monkey_normal.png', x, y)
		image_normal = Pilas.instance.mundo.motor.cargarImagen('monkey_normal.png')
        image_smile = Pilas.instance.mundo.motor.cargarImagen('monkey_smile.png')
        image_shout = Pilas.instance.mundo.motor.cargarImagen('monkey_shout.png')

//        sound_shout = pilas.sonidos.cargar('shout.wav')
//        sound_smile = pilas.sonidos.cargar('smile.wav')

        // Inicializa el actor.
        radioDeColision = 50
	}
	
	def sonreir() {
        this.imagen = image_smile
        // Luego de un segundo regresa a la normalidad
        Pilas.instance.mundo.agregarTareaUnaVez(2, [|this.normal ; false])
//        this.sound_smile.reproducir()
	}
	
	def normal() {
		this.imagen = image_normal
	}
	
}