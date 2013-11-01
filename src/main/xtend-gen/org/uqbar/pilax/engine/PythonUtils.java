package org.uqbar.pilax.engine;

import com.google.common.reflect.Reflection;
import java.lang.reflect.Method;
import java.util.List;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IntegerRange;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.StringExtensions;

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
  
  public static boolean False(final Object obj) {
    return false;
  }
  
  public static boolean True(final Object obj) {
    return true;
  }
  
  public static Object setattr(final Object target, final String attributeName, final Object value) {
    try {
      Method[] _methods = Reflection.class.getMethods();
      final Function1<Method,Boolean> _function = new Function1<Method,Boolean>() {
          public Boolean apply(final Method m) {
            String _name = m.getName();
            String _firstUpper = StringExtensions.toFirstUpper(attributeName);
            String _plus = ("set" + _firstUpper);
            boolean _equals = _name.equals(_plus);
            return Boolean.valueOf(_equals);
          }
        };
      Method _findFirst = IterableExtensions.<Method>findFirst(((Iterable<Method>)Conversions.doWrapArray(_methods)), _function);
      Object _invoke = _findFirst.invoke(target, value);
      return _invoke;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
