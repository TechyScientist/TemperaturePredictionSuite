package com.johnnyconsole.temperaturesuite.persistence.interfaces;

import com.johnnyconsole.temperaturesuite.persistence.Model;

import javax.ejb.Remote;

@Remote
public interface ModelDaoRemote {

    Model getModel(String name);
    boolean addModel(Model model);
    boolean deleteModel(Model model);

}
