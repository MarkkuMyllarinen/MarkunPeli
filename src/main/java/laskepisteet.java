import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/laskePisteet")


public class laskepisteet extends HttpServlet {

    private int kierros = 0;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String moneskoKierros = String.valueOf(kierros);

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(moneskoKierros);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        kierros++;
        String moneskoKierros = String.valueOf(kierros);


        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(moneskoKierros);
    }
}
