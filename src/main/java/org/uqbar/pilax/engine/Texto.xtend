package org.uqbar.pilax.engine

import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QFontMetrics
import com.trolltech.qt.gui.QPainter
import java.awt.Color
import java.util.Map
import org.eclipse.xtext.xbase.lib.Pair
import org.uqbar.pilax.engine.motor.ImagenMotor

import static extension org.uqbar.pilax.engine.PilasExtensions.*

/**
 * 
 */
 //RENAME: TextoMotor
class Texto extends ImagenMotor {
	// TODO: habilitar cache !
//    Map CACHE_FUENTES = newHashMap()
    @Property boolean vertical
    @Property int magnitud
    @Property QFont fuente
    @Property Color color
    @Property String texto
    Pair<Integer,Integer> areaTexto

    new(String texto, int magnitud, Motor motor, boolean vertical, QFont fuente) {
    	this.texto = texto
        this.vertical = vertical
        this.fuente = fuente
        this.magnitud = magnitud
        this.areaTexto = motor.obtenerAreaDeTexto(texto, magnitud, vertical, fuente)
    }

    override dibujarPixmap(QPainter painter, int dx, int dy) {
        //PILAX
        val nombre_de_fuente = /*if (self.fuente != null)
            Texto.cargar_fuente_desde_cache(self.fuente)
        else*/
            painter.font().family()

        fuente = new QFont(nombre_de_fuente, this.magnitud)
        val metrica = new QFontMetrics(fuente)

       	painter.setPen(color.asQColor)
        painter.setFont(fuente)

		val lines =
//        if (this.vertical)
//          [t for t in self.texto]
//        else:
            this.texto.split('\n')

		var auxdy = dy
        for (line : lines) {
            painter.drawText(dx, auxdy + this.alto, line)
            auxdy = auxdy + metrica.height()
        }
	}
	
    
//    def static void cargar_fuente_desde_cache(Object kclass, Object fuente_como_ruta) {
//        /**Carga o convierte una fuente para ser utilizada dentro del motor.
//
//        Permite a los usuarios referirse a las fuentes como ruta a archivos, sin
//        tener que preocuparse por el font-family.
//
//        :param fuente_como_ruta: Ruta al archivo TTF que se quiere utilizar.
//
//        Ejemplo:
//
//            >>> Texto.cargar_fuente_desde_cache('myttffile.ttf')
//            'Visitor TTF1'
//        */
//
//        if (! Texto.CACHE_FUENTES.containsKey(fuente_como_ruta)) {
//            ruta_a_la_fuente = pilas.utils.obtener_ruta_al_recurso(fuente_como_ruta)
//            fuente_id = QtGui.QFontDatabase.addApplicationFont(ruta_a_la_fuente)
//            Texto.CACHE_FUENTES[fuente_como_ruta] = fuente_id
//        }
//        else
//            fuente_id = Texto.CACHE_FUENTES[fuente_como_ruta]
//
//        return str(QtGui.QFontDatabase.applicationFontFamilies(fuente_id)[0])
//    }

    override ancho() {
        areaTexto.key
    }

    override alto() {
        areaTexto.value
    }
}