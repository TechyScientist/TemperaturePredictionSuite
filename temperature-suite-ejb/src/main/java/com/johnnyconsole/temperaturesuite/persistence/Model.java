package com.johnnyconsole.temperaturesuite.persistence;

import javax.persistence.*;
import java.sql.Blob;

@Entity
@Table(name="temperature-suite-models")
@NamedQueries({
        @NamedQuery(name="Model.FindByName", query="SELECT m FROM Model m WHERE m.name = :name")
})
public class Model {

    @Id
    private String name;
    private String className;
    private Blob object;

    public Model() {}

    public Model(String name, String className, Blob object) {
        this.name = name;
        this.className = className;
        this.object = object;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public Blob getObject() {
        return object;
    }

    public void setObject(Blob object) {
        this.object = object;
    }

    @Override
    public String toString() {
        return "Model [name=" + name + ", className=" +
                className + ", object=" + object.toString() + "]";
    }
}
