package com.johnnyconsole.temperaturesuite.persistence.interfaces;

import com.johnnyconsole.temperaturesuite.persistence.Model;

import javax.ejb.Local;

@Local
public interface ModelDaoLocal {

    Model getModel(String name);
    boolean addModel(Model model);
    boolean deleteModel(Model model, String myUsername);

}
