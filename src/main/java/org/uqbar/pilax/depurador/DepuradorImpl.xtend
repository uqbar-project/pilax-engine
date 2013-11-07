package org.uqbar.pilax.depurador

import com.trolltech.qt.gui.QPainter
import java.awt.Color
import java.util.List
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.depurador.modos.ModoArea
import org.uqbar.pilax.depurador.modos.ModoFisica
import org.uqbar.pilax.depurador.modos.ModoPosicion
import org.uqbar.pilax.depurador.modos.ModoPuntosDeControl
import org.uqbar.pilax.depurador.modos.ModoRadiosDeColision
import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Pilas
import org.uqbar.pilax.engine.Tecla
import org.uqbar.pilax.motor.Lienzo
import org.uqbar.pilax.motor.qt.FPS
import org.uqbar.pilax.motor.qt.Motor
import org.uqbar.pilax.utils.Utils

import static extension org.uqbar.pilax.utils.PilasExtensions.*
import static extension org.uqbar.pilax.utils.PythonUtils.*

class DepuradorImpl implements Depurador {
	List<ModoDepurador> modos
	Lienzo lienzo
	FPS fps
	Pair<Integer,Integer> posicion_del_mouse
	@Property double grosor_de_lineas = 1.0
	
	new(Lienzo lienzo, FPS fps) {
        this.modos = newArrayList
        this.lienzo = lienzo
        this.fps = fps
        this.posicion_del_mouse = (0 -> 0)
    }
	
	override comienza_dibujado(Motor motor, QPainter painter) {
    	modos.forEach[ comienzaDibujado(motor, painter, lienzo)]
	}
	
	override dibuja_al_actor(Motor motor, QPainter painter, Actor actor) {
		modos.forEach[ dibujaAlActor(motor, painter, lienzo, actor) ]
	}
	
	override termina_dibujado(Motor motor, QPainter painter) {
		if (!modos.nullOrEmpty) {
            _mostrar_cantidad_de_cuerpos(painter)
            _mostrar_cantidad_de_actores(painter)
            _mostrar_cuadros_por_segundo(painter)
            _mostrar_posicion_del_mouse(painter)
            _mostrar_nombres_de_modos(painter)
            _mostrar_cantidad_de_imagenes_cacheadas(painter)

			modos.forEach[ terminaDibujado(motor, painter, lienzo)]
		}
	}
	
	def _mostrar_cantidad_de_cuerpos(QPainter painter) {
        val bordes = Utils.obtenerBordes
//        PILAX: fisica
        val total_de_cuerpos = 0 // Pilas.instance.escenaActual.fisica.cantidad_de_cuerpos()
        val texto = "Cantidad de cuerpos fisicos: " + total_de_cuerpos
        lienzo.texto_absoluto(painter, texto, bordes.izquierda + 10, bordes.abajo + 50, Color.white)
    }
    
    def _mostrar_cantidad_de_actores(QPainter painter) {
        val bordes = Utils.obtenerBordes
        val total_de_actores = Pilas.instance.escenaActual.actores.size
        val texto = "Cantidad de actores: " + total_de_actores
        lienzo.texto_absoluto(painter, texto, bordes.izquierda + 10, bordes.abajo + 30, Color.white)
	}
	
	def _mostrar_cuadros_por_segundo(QPainter painter) {
        val bordes = Utils.obtenerBordes
        val rendimiento = fps.cuadros_por_segundo
        val texto = "Cuadros por segundo: " + rendimiento
        lienzo.texto_absoluto(painter, texto, bordes.izquierda + 10, bordes.abajo + 10, Color.white)
    }
    
    def _mostrar_posicion_del_mouse(QPainter painter) {
        val bordes = Utils.obtenerBordes
        val texto = "Posición del mouse: x=" + posicion_del_mouse.x + " y=" + posicion_del_mouse.y
        lienzo.texto_absoluto(painter, texto, bordes.derecha - 230, bordes.abajo + 10, Color.white)
    }
    
    def _mostrar_nombres_de_modos(QPainter painter) {
        var dy = 0
        val bordes = Utils.obtenerBordes

        for (modo : modos) {
            val texto = modo.tecla + " " + modo.class.simpleName + " habilitado."
            self.lienzo.texto_absoluto(painter, texto, bordes.izquierda + 10, bordes.arriba -20 +dy, Color.white)
            dy = dy - 20
        }
	}
	
	def _mostrar_cantidad_de_imagenes_cacheadas(QPainter painter) {
        val bordes = Utils.obtenerBordes
        val total_de_imagenes_cacheadas = 0 // PILAX pilas.mundo.motor.libreria_imagenes.obtener_cantidad()
        val texto = "Cantidad de imagenes cacheadas: " + total_de_imagenes_cacheadas
        lienzo.texto_absoluto(painter, texto, bordes.izquierda + 10, bordes.abajo + 70, Color.white)
    }
	
	override cuando_pulsa_tecla(Tecla codigo_tecla, Object texto_tecla) {
		switch(codigo_tecla) {
//			case Tecla.F5:
//            	self._alternar_modo(ModoWidgetLog)
//            case Tecla.F6:	
//            	pilas.utils.imprimir_todos_los_eventos()
//			case Tecla.F7:
//            	self._alternar_modo(ModoInformacionDeSistema)
            case Tecla.F8:
	            self._alternar_modo(ModoPuntosDeControl)
	        case Tecla.F9:
	            self._alternar_modo(ModoRadiosDeColision)
	        case Tecla.F10:
	        	this._alternar_modo(ModoArea)
	       	case Tecla.F11:
            	self._alternar_modo(ModoFisica)
			case Tecla.F12:            	
	            _alternar_modo(ModoPosicion)
	        case Tecla.PLUS:
            	_cambiar_grosor_de_bordes(1)
            case Tecla.MINUS:
            	_cambiar_grosor_de_bordes(-1)
		}
	}
	
	def <T  extends ModoDepurador> _alternar_modo(Class<T> clase_del_modo) {
        val clases_activas = modos.map[it.class]

        if (clase_del_modo.in(clases_activas))
            _desactivar_modo(clase_del_modo)
        else
            _activar_modo(clase_del_modo)
	}
	
	def _activar_modo(Class<? extends ModoDepurador> clase_del_modo) {
        val instancia_del_modo = clase_del_modo.newInstanceWith(this)
        modos.add(instancia_del_modo)
        // PILAX: es una hackeada en pilas. Hay que hacerlo mejor
//        modos.sort[a, b | a.orden_de_tecla < b.orden_de_tecla]
    }

    def _desactivar_modo(Class<? extends ModoDepurador> clase_del_modo) {
        val instancia_a_eliminar = modos.findFirst[it.class == clase_del_modo]
        self.modos.remove(instancia_a_eliminar)
        instancia_a_eliminar.sale_del_modo
	}
	
	def _cambiar_grosor_de_bordes(int cambio) {
        grosor_de_lineas = Math.max(1, grosor_de_lineas + cambio)
    }
	
	override boolean cuando_mueve_el_mouse(int x, int y) {
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
	
	def void comienzaDibujado(Motor motor, QPainter painter, Lienzo lienzo) {}
	
	def void dibujaAlActor(Motor motor, QPainter painter, Lienzo lienzo, Actor actor) {}
	
	def void terminaDibujado(Motor motor, QPainter painter, Lienzo lienzo) {}
	
	def void sale_del_modo() {}
	
	def _obtener_posicion_relativa_a_camara(Actor actor) {
        if (actor.fijo)
            return (actor.x -> actor.y)
        else
            return (actor.x - Pilas.instance.escenaActual.camara.x -> actor.y - Pilas.instance.escenaActual.camara.y)
	}
	
}