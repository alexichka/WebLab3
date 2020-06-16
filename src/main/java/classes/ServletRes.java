package classes;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.InvocationTargetException;
import java.rmi.RemoteException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/result")
public class ServletRes extends HttpServlet {
    private String getUserDataXMLRepresentation(Customer customer) throws JAXBException, SQLException, ClassNotFoundException, IncorrectConstructorParameters, RemoteException, NoSuchMethodException, InstantiationException, IllegalAccessException, InvocationTargetException {
        customer.setOrders(new ClassDB().getCustomersProduct(customer));

        StringWriter writer = new StringWriter();
        JAXBContext context = JAXBContext.newInstance(Customer.class);
        Marshaller marshaller = context.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
        marshaller.marshal(customer, writer);

        return writer.toString();
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            HttpSession httpSession = req.getSession();
            ClassDB connectionWithDB = new ClassDB();
            String[] split = req.getReader().readLine().split("&");
            String login = split[0].substring(split[0].indexOf('=') + 1);
            String password = split[1].substring(split[1].indexOf('=') + 1);
            Customer cust = null;
            cust = connectionWithDB.getCustomer(login, password);
            httpSession.setAttribute("customer", cust);
            List<Product> products = null;

            if (cust != null) {
                resp.setContentType("application/xml");
                try (PrintWriter writer = resp.getWriter()) {
                    writer.println(getUserDataXMLRepresentation(cust));
                } catch (JAXBException | SQLException | ClassNotFoundException | IncorrectConstructorParameters | NoSuchMethodException | InstantiationException | IllegalAccessException | InvocationTargetException e) {
                    e.printStackTrace();
                }

            } else {
                resp.setContentType("text/html");
                try (PrintWriter writer = resp.getWriter()) {
                    writer.println(
                            "<p class=\"main-redirect\">\n" +
                                    "    User not found<br>you will be redirected to the login page after 5 seconds\n" +
                                    "    <a href=\"index.jsp\">return now</a>\n" +
                                    "</p>\n" +
                                    "<meta http-equiv=\"refresh\" content=\"5; URL=index.jsp\">"
                    );
                }
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IncorrectConstructorParameters incorrectConstructorParameters) {
            incorrectConstructorParameters.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}