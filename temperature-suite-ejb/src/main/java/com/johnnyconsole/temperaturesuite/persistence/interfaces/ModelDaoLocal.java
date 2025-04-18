package com.johnnyconsole.temperaturesuite.persistence.interfaces;

import com.johnnyconsole.temperaturesuite.persistence.Model;

import javax.ejb.Local;
import java.util.List;

@Local
public interface ModelDaoLocal {

    Model getModel(String name);
    List getAllModels();
    boolean addModel(Model model);
    boolean deleteModel(Model model);

}
