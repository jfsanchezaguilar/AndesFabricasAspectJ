package aspectos;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.reflect.CodeSignature;
import org.aspectj.lang.reflect.MethodSignature;

import java.lang.reflect.Method;
import java.lang.reflect.Type;

public aspect Logger {

	static final void println(String s) {
		System.out.println(s);
	}

	pointcut logger(): call(uniandes.cupi2.impuestosCarro.mundo.* *(..));

	before(): logger(){
		String className = thisJoinPointStaticPart.getSignature().getDeclaringType().getName();
		println("------------Logger----------------");
		println("Class: " + className.substring(className.indexOf("mundo.") + 6));
		println("Metodo: " + thisJoinPointStaticPart.getSignature().getName());
		printParameters(thisJoinPoint);
	}

	after() returning(Object r): logger(){
		Method method = ((MethodSignature) thisJoinPoint.getSignature()).getMethod();
		Type type = method.getGenericReturnType();
		String className = type.getTypeName();
		System.out.println("Return Type: " + className.substring(className.indexOf("mundo.") + 6));
		System.out.println("Returned: " + r);
	}

	after() throwing(Throwable e): logger(){
		println("------After Exception--------------");
		System.out.println("Excepcion: " + e.toString());
	}

	static private void printParameters(JoinPoint jp) {
		println("Arguments: ");
		Object[] args = jp.getArgs();
		String[] names = ((CodeSignature) jp.getSignature()).getParameterNames();
		Class[] types = ((CodeSignature) jp.getSignature()).getParameterTypes();
		for (int i = 0; i < args.length; i++) {
			println("  " + (i + 1) + ". " + names[i] + " : " + types[i].getName() + " = " + args[i]);
		}
	}

}