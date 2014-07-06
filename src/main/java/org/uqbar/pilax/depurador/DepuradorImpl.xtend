package org.uqbar.pilax.depurador

import java.awt.Color
import java.util.List
import org.uqbar.pilax.depurador.modos.ModoAngulo
import org.uqbar.pilax.depurador.modos.ModoArea
import org.uqbar.pilax.depurador.modos.ModoCamara
import org.uqbar.pilax.depurador.modos.ModoFisica
import org.uqbar.pilax.depurador.modos.ModoPosicion
import org.uqbar.pilax.depurador.modos.ModoPuntosDeControl
import org.uqbar.pilax.depurador.modos.ModoRadiosDeColision
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.fisica.Fisica
import org.uqbar.pilax.motor.Lienzo
import org.uqbar.pilax.motor.Motor
import org.uqbar.pilax.motor.PilasPainter
import org.uqbar.pilax.motor.qt.FPS
import org.uqbar.pilax.utils.Utils

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

class DepuradorImpl implements Depurador {
	List<ModoDepurador> modos
	Lienzo lienzo
	FPS fps
	Pair<Double,Double> posicion_del_mouse
	@Property double grosor_de_lineas = 1.0
	
	new(Lienzo lienzo, FPS fps) {
        this.modos = newArrayList
        this.lienzo = lienzo
        this.fps = fps
        this.posicion_del_mouse = origen
    }
	
	override comienzaDibujado(Motor motor, PilasPainter painter) {
    	modos.forEach[ comienzaDibujado(motor, painter, lienzo)]
	}
	
	override dibujaAlActor(Motor motor, PilasPainter painter, Actor actor) {
		modos.forEach[ dibujaAlActor(motor, painter, lienzo, actor) ]
	}
	
	override terminaDibujado(Motor motor, PilasPainter painter) {
		if (!modos.nullOrEmpty) {
            mostrarCantidadDeCuerpos(painter)
            mostrarCantidadDeActores(painter)
            mostrarCuadrosPorSegundo(painter)
            mostrarPosicionDelMouse(painter)
            mostrarNombresDeModos(painter)
            mostrarCantidadDeImagenesCacheadas(painter)
			modos.forEach[ terminaDibujado(motor, painter, lienzo)]
		}
	}
	
	def mostrarCantidadDeCuerpos(PilasPainter painter) {
        val bordes = Utils.bordes
        //HACK casteo a fisica jbox
        val total_de_cuerpos = (pilas.escenaActual.fisica as Fisica).cantidad_de_cuerpos()
        val texto = "Cantidad de cuerpos fisicos: " + total_de_cuerpos
        lienzo.texto_absoluto(painter, texto, bordes.izquierda + 10, bordes.abajo + 50, Color.white)
    }
    
    def mostrarCantidadDeActores(PilasPainter painter) {
        val bordes = Utils.bordes
        val total_de_actores = Pilas.instance.escenaActual.actores.size
        val texto = "Cantidad de actores: " + total_de_actores
        lienzo.texto_absoluto(painter, texto, bordes.izquierda + 10, bordes.abajo + 30, Color.white)
	}
	
	def mostrarCuadrosPorSegundo(PilasPainter painter) {
        val bordes = Utils.bordes
        val rendimiento = fps.cuadros_por_segundo
        val texto = "Cuadros por segundo: " + rendimiento
        lienzo.texto_absoluto(painter, texto, bordes.izquierda + 10, bordes.abajo + 10, Color.white)
    }
    
    def mostrarPosicionDelMouse(PilasPainter painter) {
        val bordes = Utils.bordes
        val texto = "Posición del mouse: x=" + posicion_del_mouse.x + " y=" + posicion_del_mouse.y
        lienzo.texto_absoluto(painter, texto, bordes.derecha - 230, bordes.abajo + 10, Color.white)
    }
    
    def mostrarNombresDeModos(PilasPainter painter) {
        var dy = 0
        val bordes = Utils.bordes

        for (modo : modos) {
            val texto = modo.tecla + " " + modo.class.simpleName + " habilitado."
            lienzo.texto_absoluto(painter, texto, bordes.izquierda + 10, bordes.arriba -20 +dy, Color.white)
            dy = dy - 20
        }
	}
	
	def mostrarCantidadDeImagenesCacheadas(PilasPainter painter) {
        val bordes = Utils.bordes
        val total_de_imagenes_cacheadas = 0 // PILAX pilas.mundo.motor.libreria_imagenes.obtener_cantidad()
        val texto = "Cantidad de imagenes cacheadas: " + total_de_imagenes_cacheadas
        lienzo.texto_absoluto(painter, texto, bordes.izquierda + 10, bordes.abajo + 70, Color.white)
    }
	
	override cuandoPulsaTecla(Tecla codigo_tecla, Object texto_tecla) {
		switch(codigo_tecla) {
			case Tecla.F3:
				alternarModo(ModoCamara)
			case Tecla.F4:
				alternarModo(ModoAngulo)
//			case Tecla.F5:
//            	self.alternarModo(ModoWidgetLog)
//            case Tecla.F6:	
//            	pilas.utils.imprimir_todos_los_eventos()
//			case Tecla.F7:
//            	self.alternarModo(ModoInformacionDeSistema)
            case Tecla.F8:
	            alternarModo(ModoPuntosDeControl)
	        case Tecla.F9:
	            alternarModo(ModoRadiosDeColision)
	        case Tecla.F10:
	        	alternarModo(ModoArea)
	       	case Tecla.F11:
            	alternarModo(ModoFisica)
			case Tecla.F12:            	
	            alternarModo(ModoPosicion)
	        case Tecla.PLUS:
            	cambiarGrosorDeBordes(1)
            case Tecla.MINUS:
            	cambiarGrosorDeBordes(-1)
		}
	}
	
	def <T  extends ModoDepurador> alternarModo(Class<T> claseDelModo) {
        val clasesActivas = modos.map[it.class]

        if (clasesActivas.contains(claseDelModo))
            desactivarModo(claseDelModo)
        else
            activarModo(claseDelModo)
	}
	
	def activarModo(Class<? extends ModoDepurador> claseDelModo) {
        val modo = claseDelModo.newInstanceWith(this)
        modos.add(modo)
        // PILAX: es una hackeada en pilas. Hay que hacerlo mejor
//        modos.sort[a, b | a.orden_de_tecla < b.orden_de_tecla]
    }

    def desactivarModo(Class<? extends ModoDepurador> clase) {
        val modo = modos.findFirst[it.class == clase]
        modos.remove(modo)
        modo.saleDelModo
	}
	
	def cambiarGrosorDeBordes(int cambio) {
        grosor_de_lineas = Math.max(1, grosor_de_lineas + cambio)
    }
	
	override boolean cuandoMueveElMouse(double x, double y) {
		posicion_del_mouse = x -> y
        true
	}
	
}

abstract class ModoDepurador {
	@Property DepuradorImpl depurador
	@Property Tecla tecla
	
	//PILAX REFACTOR: evitar la duplicidad de la tecla, que el depurador ya le pase la tecla
	// asociada!
	new(DepuradorImpl impl, Tecla tecla) {
		this.depurador = impl
		this.tecla = tecla
	}
	
	def void comienzaDibujado(Motor motor, PilasPainter painter, Lienzo lienzo) {}
	
	def void dibujaAlActor(Motor motor, PilasPainter painter, Lienzo lienzo, Actor actor) {}
	
	def void terminaDibujado(Motor motor, PilasPainter painter, Lienzo lienzo) {}
	
	def void saleDelModo() {}
	
}