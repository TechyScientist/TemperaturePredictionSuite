package com.johnnyconsole.temperaturesuite.persistence.impl;

import com.johnnyconsole.temperaturesuite.persistence.Model;
import com.johnnyconsole.temperaturesuite.persistence.interfaces.ModelDaoLocal;
import com.johnnyconsole.temperaturesuite.persistence.interfaces.ModelDaoRemote;

import javax.ejb.Stateful;
import javax.enterprise.inject.Alternative;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Stateful
@Alternative
public class ModelDaoImpl implements ModelDaoLocal, ModelDaoRemote {

    @PersistenceContext(unitName="model")
    private EntityManager manager;


    @Override
    public Model getModel(String name) {
        try {
            Query query = manager.createNamedQuery("Model.FindByName");
            query.setParameter("name", name);
            return (Model) query.getSingleResult();
        } catch(Exception e) {
            return null;
        }
    }

    @Override
    public boolean addModel(Model model) {
        try {
            manager.persist(model);
            return true;
        }
        catch(Exception e) {
            return false;
        }
    }

    @Override
    public boolean deleteModel(Model model) {
        try {
            manager.remove((manager.contains(model) ? model : manager.merge(model)));
            return true;
        }
        catch (Exception e) {
            return false;
        }
    }
}