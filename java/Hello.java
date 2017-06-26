import java.util.Date;
import java.text.SimpleDateFormat;

public class Hello {
    public static void main(String []args) {
        System.out.println("Hello World");		// 打印 Hello World

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		System.out.println(df.format(new Date()));// new Date()为获取当前系统时间

		System.out.println(new Date().getTime());
    }
}