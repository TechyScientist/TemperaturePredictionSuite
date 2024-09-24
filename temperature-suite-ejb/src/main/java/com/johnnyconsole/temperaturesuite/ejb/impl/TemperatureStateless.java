package com.johnnyconsole.temperaturesuite.ejb.impl;


import com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatelessLocal;
import com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatelessRemote;

import javax.ejb.Stateless;
import java.io.File;

@Stateless
public class TemperatureStateless
        implements TemperatureStatelessLocal, TemperatureStatelessRemote {

    public double predict(String model, int year, int month, int day) {
        return 0;
    }

    public void createModel(String modelClass, String modelName, File trainData) {

    }
}
