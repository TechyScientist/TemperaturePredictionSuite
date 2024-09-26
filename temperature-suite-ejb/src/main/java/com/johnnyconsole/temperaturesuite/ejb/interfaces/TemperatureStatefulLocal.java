package com.johnnyconsole.temperaturesuite.ejb.interfaces;

import com.johnnyconsole.temperaturesuite.persistence.User;

import javax.ejb.Local;

@Local
public interface TemperatureStatefulLocal {

    boolean isLoggedIn();
    String loggedInUsername();
    String loggedInName();
    int loggedInAccessLevel();
    void logIn(String username, String name, int accessLevel);
    void logOut();

}
