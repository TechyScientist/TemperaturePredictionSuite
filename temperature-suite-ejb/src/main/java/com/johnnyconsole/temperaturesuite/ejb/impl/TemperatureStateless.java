package com.johnnyconsole.temperaturesuite.ejb.impl;


import com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatelessLocal;
import com.johnnyconsole.temperaturesuite.persistence.Model;
import com.johnnyconsole.temperaturesuite.persistence.interfaces.ModelDaoLocal;
import weka.classifiers.trees.REPTree;
import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instances;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import java.io.File;
import java.io.ObjectInputStream;
import java.util.ArrayList;
import java.util.Arrays;

@Stateless
public class TemperatureStateless implements TemperatureStatelessLocal {

    @EJB
    ModelDaoLocal modelBean;

    public double predict(String model, String modelClass, int year, int month, int day) {
        try {
            Model m = modelBean.getModel(model);
            switch(modelClass) {
                case "REPTree":
                    REPTree repTree = (REPTree) (new ObjectInputStream(m.getObject().getBinaryStream()).readObject());
                    ArrayList<Attribute> attributes = new ArrayList<>(
                            Arrays.asList(new Attribute("Year"),
                                    new Attribute("Month"),
                                    new Attribute("Day"),
                                    new Attribute("Mean Temperature")));

                    Instances prediction = new Instances("TemperaturePredict", attributes, 0);
                    prediction.add(new DenseInstance(1, new double[]{year, month, day}));
                    prediction.setClassIndex(prediction.numAttributes() - 1);
                    return (int) (100 * repTree.classifyInstance(prediction.firstInstance())) / 100.0;
                default:
                    return Double.MIN_VALUE;
            }

        } catch(Exception e) {
            return Double.MIN_VALUE;
        }
    }

    public void createModel(String modelClass, String modelName, File trainData) {

    }
}
