import javax.persistence.*;
import java.util.LinkedList;
import java.util.List;

@Entity
@Table(name="Departments")
public class Department {
    @Id
    private int code;
    private String descrip;

    @OneToMany(mappedBy = "code")
    private List <Employee> employees;

    public Department(int i, String sales, EntityManager em) {
        this();
        em.getTransaction().begin();
        code = i;
        descrip = sales;
        employees = new LinkedList<>();
        em.persist(this);

        em.getTransaction().commit();
    }

    public Department() {

    }

    @Override
    public String toString() {
        return "Department{" +
                "code=" + code +
                ", descrip='" + descrip + '\'' +
                ", employees=" + employees +
                '}';
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getDescrip() {
        return descrip;
    }

    public void setDescrip(String descrip) {
        this.descrip = descrip;
    }

    public List<Employee> getEmployees() {
        return employees;
    }

    public void setEmployees(List<Employee> employees, EntityManager em) {
        em.getTransaction().begin();
        for (Employee employee : employees) {
            employee.setCode(code);
            em.persist(employee);
        }
        em.getTransaction().commit();

        this.employees = employees;
    }
}
