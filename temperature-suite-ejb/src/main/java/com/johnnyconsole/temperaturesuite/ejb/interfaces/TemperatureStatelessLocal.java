package com.johnnyconsole.temperaturesuite.ejb.interfaces;

import javax.ejb.Local;
import java.io.File;

@Local
public interface TemperatureStatelessLocal {

    double predict(String model, String modelClass, int year, int month, int day);
    void createModel(String modelClass, String modelName, File trainData);

}
