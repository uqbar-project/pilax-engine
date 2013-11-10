package org.uqbar.pilax.actores

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.motor.Superficie

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*
import org.uqbar.pilax.utils.Utils

/**
 * 
 */
class ActorGlobo extends Actor {
	@Property Dialogo dialogo
	@Property Pair<Integer,Integer> dimension
	
	new(String texto, int x, int y, boolean autoEliminar) {
		this(texto, x, y, true, autoEliminar, 0, 0)
	} 
	
	new(String texto, int x, int y, boolean avance_con_clicks, boolean autoEliminar, int ancho_globo, int alto_globo) {
		super(crearSuperficie(texto, x, y, ancho_globo, alto_globo), x, y)
        this.dialogo = null
        
        self.centroRelativo = (PosicionCentro.DERECHA -> PosicionCentro.ABAJO)
        //TODO: pilax
        this.escala = 0.1
        Utils.interpolar(this, "escala", #[1d], 1)
        
        dimension = ancho_globo -> alto_globo 
		
        if (avance_con_clicks)
            escena.clickDeMouse.conectar("", [d|cuando_quieren_avanzar])

        if (autoEliminar)
            escena.tareas.unaVez(3, [|eliminar; false])
	}
	
	def static crearSuperficie(String texto, int x, int y, int ancho_globo, int alto_globo) {
		val areaTexto = motor.obtenerAreaDeTexto(texto)
		var ancho = areaTexto.ancho
        var alto = areaTexto.alto

        // Podemos pasar el ancho del globo ya que si contiene opciones
        // cuyo texto es más largo que la cabecera del globo, no queda bien.
        if (ancho_globo == 0)
            ancho = ((ancho + 12) - (ancho % 12)).intValue
        else
            if (ancho_globo > ancho)
                ancho = ancho_globo
            else
                ancho = ((ancho + 12) - (ancho % 12)).intValue

        // Lo mismo para el alto
        if (alto_globo == 0)
            alto = ((alto + 12) - alto % 12).intValue
        else
            alto = alto + alto_globo

        val imagen = motor.crearSuperficie(ancho + 36, alto + 24 + 35)
        
        _pintar_globo(imagen, ancho, alto)
        imagen.texto(texto, 17, 20)
        imagen
	}
	
	override Superficie getImagen() {
		super.getImagen() as Superficie
	}
	
	def static _pintar_globo(Superficie imagen, int ancho, int alto) {
        val imagenGlobo = motor.cargarImagen("globo.png")

        // esquina sup-izq
        imagen.pintar_parte_de_imagen(imagenGlobo, 0, 0, 12, 12, 0, 0)

        // borde superior
        for (r : range(0, ancho + 12, 12))
            imagen.pintar_parte_de_imagen(imagenGlobo, 12, 0, 12, 12, 12 + r, 0)

         // esquina sup-der
        imagen.pintar_parte_de_imagen(imagenGlobo, 100, 0, 12, 12, 12 + ancho + 12, 0)

        // centro del dialogo
        for (y : range(0, alto + 12, 12)) {
            // borde izquierdo
            imagen.pintar_parte_de_imagen(imagenGlobo, 0, 12, 12, 12, 0, 12 + y)
            // linea horizontal blanca, para el centro del dialogo.
            for (x : range(0, ancho + 12, 12)) {
                imagen.pintar_parte_de_imagen(imagenGlobo, 12, 12, 12, 12, 12 + x, 12 + y)
            }

            // borde derecho
           	imagen.pintar_parte_de_imagen(imagenGlobo, 100, 12, 12, 12, 12 + ancho + 12, 12 + y)
		}
        // parte inferior
        imagen.pintar_parte_de_imagen(imagenGlobo, 0, 35, 12, 12, 0, 0 + alto + 12 + 12)

        // linea horizontal de la parte inferior
        for (x : range(0, ancho + 12, 12))
            imagen.pintar_parte_de_imagen(imagenGlobo, 12, 35, 12, 12, 12 + x, 0 + alto + 12 + 12)

        imagen.pintar_parte_de_imagen(imagenGlobo, 100, 35, 12, 12, 12 + ancho + 12, 0 + alto + 12 + 12)
        // Pico de la parte de abajo
        imagen.pintar_parte_de_imagen(imagenGlobo, 67, 35, 33, 25, ancho - 12, 0 + alto + 12 + 12)
	}
	
	/** "Función que se ejecuta al hacer click para avanzar o eliminar el globo." */
	def cuando_quieren_avanzar() {
        if (dialogo != null)
            dialogo.avanzarAlSiguienteDialogo
        else
            eliminar
    }
	
}