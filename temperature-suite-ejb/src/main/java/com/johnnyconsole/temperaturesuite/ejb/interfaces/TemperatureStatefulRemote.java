package com.johnnyconsole.temperaturesuite.ejb.interfaces;

import com.johnnyconsole.temperaturesuite.persistence.User;

import javax.ejb.Remote;

@Remote
public interface TemperatureStatefulRemote {

    boolean isLoggedIn();
    String loggedInUsername();
    String loggedInName();
    int loggedInAccessLevel();
    void logIn(String username, String name, int accessLevel);
    void logOut();

}
