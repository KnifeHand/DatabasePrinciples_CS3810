import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.LinkedList;
import java.util.List;

public class HelloHibernate {

    public static void main(String[] args) {

        // EntityManager initialization
        EntityManagerFactory emf = Persistence.createEntityManagerFactory
                ("my-persistence-unit");
        EntityManager em = emf.createEntityManager();
//        em.getTransaction().begin();

        // persisting an object
//        Employee employee = new Employee();
//        employee.setId(10);
//        employee.setName("Perry Rhodan");
//        employee.setCode(250000);
//        em.persist(employee);

        Department sales = new Department(3, "sales", em);
        List <Employee> employees = new LinkedList<>();
        employees.add(em.find(Employee.class, 1));
        employees.add(em.find(Employee.class, 2));
        sales.setEmployees(employees, em);


        // updating an existing entity
//        Employee morbid = em.find(Employee.class, 2);
//        morbid.setCode(morbid.getCode() + 500);

        // EntityManager commit/close
        em.getTransaction().commit();
        em.close();
    }
}