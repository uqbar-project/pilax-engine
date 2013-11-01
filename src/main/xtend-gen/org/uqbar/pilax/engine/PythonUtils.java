package org.uqbar.pilax.engine;

import java.util.List;
import org.eclipse.xtext.xbase.lib.IntegerRange;

@SuppressWarnings("all")
public class PythonUtils {
  public static <T extends Object> T self(final T aThis) {
    return aThis;
  }
  
  public static IntegerRange range(final int numero) {
    IntegerRange _upTo = new IntegerRange(0, numero);
    return _upTo;
  }
  
  public static int id(final Object obj) {
    int _identityHashCode = System.identityHashCode(obj);
    return _identityHashCode;
  }
  
  public static <T extends Object> T None(final Object obj) {
    return null;
  }
  
  public static <E extends Object> E pop(final List<E> list, final int index) {
    E _remove = list.remove(index);
    return _remove;
  }
  
  public static void pass(final Object obj) {
  }
  
  public static <T extends Object> T QtCore(final T t) {
    return t;
  }
}
