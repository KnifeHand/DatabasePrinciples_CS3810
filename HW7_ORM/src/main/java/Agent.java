//CS3810 - Principles of Database Systems - Spring 2021
//        * Instructor: Thyago Mota
//        * Description: Homework 07 - Agent
//        * Student Name: Matt Hurt

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
@Entity
@Table(name = "agents")
public class Agent {
    @Id
    private int id;
    private String name;
    private int ouid;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getOuid() {
        return ouid;
    }
    public void setOuid(int ouid) {
        this.ouid = ouid;
    }
    @Override
    public String toString() {
        return "Agent{" +
                "id=" + id +
                ", name='" + name + '\'' +
                '}';
    }
}