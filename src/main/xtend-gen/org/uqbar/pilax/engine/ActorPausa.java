package org.uqbar.pilax.engine;

import org.eclipse.xtext.xbase.lib.Pair;
import org.uqbar.pilax.engine.Actor;

@SuppressWarnings("all")
public class ActorPausa extends Actor {
  public ActorPausa() {
    this(0, 0);
  }
  
  public ActorPausa(final int x, final int y) {
    super("icono_pausa.png", x, y);
    Pair<Integer,Integer> _mappedTo = Pair.<Integer, Integer>of(Integer.valueOf(0), Integer.valueOf(0));
    this.setCentro(_mappedTo);
  }
}
