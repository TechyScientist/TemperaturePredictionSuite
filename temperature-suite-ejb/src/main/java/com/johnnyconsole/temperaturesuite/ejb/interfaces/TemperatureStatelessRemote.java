package com.johnnyconsole.temperaturesuite.ejb.interfaces;

import javax.ejb.Remote;
import java.io.File;

@Remote
public interface TemperatureStatelessRemote {

    double predict(String model, int year, int month, int day);
    void createModel(String modelClass, String modelName, File trainData);

}
