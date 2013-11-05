package org.uqbar.pilax.habilidades

import org.uqbar.pilax.engine.Actor
import org.uqbar.pilax.engine.Control
import org.uqbar.pilax.engine.DataEventoTeclado
import org.uqbar.pilax.engine.Habilidad

import static extension org.uqbar.pilax.engine.PilasExtensions.*
import static extension org.uqbar.pilax.engine.PythonUtils.*
import org.uqbar.pilax.engine.DataEvento

/** Hace que un actor cambie de posición con pulsar el teclado.*/
class MoverseConTeclado extends Habilidad {
    static int CUATRO_DIRECCIONES = 4
    static int OCHO_DIRECCIONES = 8
    @Property int velocidad_maxima = 4
    @Property int direcciones = OCHO_DIRECCIONES
    @Property int aceleracion = 1
    @Property double deceleracion = 0.1
    @Property int velocidad_rotacion = 1
    @Property boolean marcha_atras = true
    @Property boolean con_rotacion = false 
    Control control
    
    // dinamicas
    @Property double velocidad

	/**
	 * """Inicializa la habilidad.

        :param receptor: Referencia al actor que aprenderá la habilidad.
        :param control: Control al que va a responder para mover el Actor.
        :param direcciones: Establece si puede mover en cualquier direccion o unicamente en 4 direcciones arriba, abajo, izquierda y derecha. El parametro con_rotacion establece las direcciones a OCHO_DIRECCIONES siempre.
        :param velocidad_maxima: Velocidad maxima en pixeles a la que se moverá el Actor.
        :param aceleracion: Indica lo rapido que acelera el actor hasta su velocidad máxima.
        :param deceleracion: Indica lo rapido que decelera el actor hasta parar.
        :param con_rotacion: Si deseas que el actor rote pulsando las teclas de izquierda y derecha.
        :param velocidad_rotacion: Indica lo rapido que rota un actor sobre si mismo.
        :param marcha_atras: Posibilidad de ir hacia atrás. (True o False)
	 
	 */
    new(Actor receptor/* control=None, direcciones=OCHO_DIRECCIONES, velocidad_maxima=4,
                 aceleracion=1, deceleracion=0.1, con_rotacion=False, velocidad_rotacion=1, marcha_atras=True */) {
        super(receptor)
        pilas.escenaActual.actualizar.conectar("moverseConTeclado", [d| on_key_press(d)])

        self.control = self.receptor.escena.control
        self.velocidad = 0
    }

    def on_key_press(DataEvento evento) {
        val c = self.control
        if (self.con_rotacion) {

            if (c.izquierda)
                self.receptor.rotacion = self.receptor.rotacion - self.velocidad_rotacion * self.velocidad_maxima
            else if (c.derecha)
                self.receptor.rotacion = self.receptor.rotacion + self.velocidad_rotacion * self.velocidad_maxima

            if (c.arriba)
                self.avanzar(1)
            else if (c.abajo) {
                if (self.marcha_atras)
                    self.avanzar(-1)
                else
                    self.decelerar()
            }
            else
                self.decelerar()

            val rotacion_en_radianes = Math.toRadians(-self.receptor.rotacion + 90)
            val dx = Math.cos(rotacion_en_radianes) * self.velocidad
            val dy = Math.sin(rotacion_en_radianes) * self.velocidad
            self.receptor.x = self.receptor.x + dx.intValue
            self.receptor.y = self.receptor.y + dy.intValue
		}
        else {
            if (self.direcciones == OCHO_DIRECCIONES) {
                if (c.izquierda)
                    self.receptor.x = self.receptor.x - self.velocidad_maxima
                else if (c.derecha)
                    self.receptor.x = self.receptor.x + self.velocidad_maxima

                if (c.arriba)
                    self.receptor.y = self.receptor.y + self.velocidad_maxima
                else if (c.abajo)
                    if (self.marcha_atras)
                        self.receptor.y = self.receptor.y - self.velocidad_maxima
            }
            else {
                if (c.izquierda)
                    self.receptor.x = self.receptor.x - self.velocidad_maxima
                else if (c.derecha)
                    self.receptor.x = self.receptor.x + self.velocidad_maxima
                else if (c.arriba)
                    self.receptor.y = self.receptor.y + self.velocidad_maxima
                else if (c.abajo)
                    if (self.marcha_atras)
                        self.receptor.y = self.receptor.y - self.velocidad_maxima
            }
         }
    }

    def decelerar() { 
        if (self.velocidad > self.deceleracion)
            self.velocidad = self.velocidad - self.deceleracion
        else if (self.velocidad < -self.deceleracion)
            self.velocidad = self.velocidad + self.deceleracion
        else
            self.velocidad = 0
    }

    def avanzar(int delta) {
        self.velocidad = self.velocidad + self.aceleracion * delta

        if (self.velocidad > self.velocidad_maxima)
            self.velocidad = self.velocidad_maxima
        else if (self.velocidad < -self.velocidad_maxima / 2)
            self.velocidad = -self.velocidad_maxima / 2
    }
    
}